require 'rspec'
require 'rack/test'
require 'webmock/rspec'
require_relative '../worried_app'

describe Worried do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:json) { File.read File.expand_path("../fixtures/#{file}.json", __FILE__) }

  describe 'GET /' do
    it 'responds with a 404' do
      get '/'
      expect(last_response.status).to eq(404)
    end
  end

  describe 'GET /status' do
    it 'should respond a successful response' do
      get '/status'
      last_response.should be_ok
    end
  end

  describe 'NewRelic webhooks' do
    before { ENV['PUSHBULLET_API_KEY'] = 'key' }

    context 'test' do
      let(:file) { 'test' }

      it 'responds with a 200 and an "ok" response' do
        req = stub_request(:post, 'https://key:@api.pushbullet.com/v2/pushes').with do |request|
          request.body.should =~ /type=note&title=Unknown\+message/
        end
        post '/new_relic/push_bullet', json, 'CONTENT_TYPE' => 'application/json'
        expect(last_response.status).to eq(200)
        req.should have_been_requested
      end
    end

    context 'server alert policy opened' do
      let(:file) { 'server_alert_policy_opened' }

      it 'sends a push event to PushBullet with the appropriate title and message' do
        req = stub_request(:post, 'https://key:@api.pushbullet.com/v2/pushes').with do |request|
          request.body.should == 'type=note&title=New+alert+on+my.server.local&body=Alert+opened%3A+Disk+IO+%3E+85%25%5Cn%5Cn2014-03-04T14%3A41%3A07-08%3A00'
        end
        post '/new_relic/push_bullet', json, 'CONTENT_TYPE' => 'application/json'
        req.should have_been_requested
      end
    end
  end
end
