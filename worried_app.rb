# worried_app.rb
 
require 'rack'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'worried'
require 'worried/inputs/new_relic'
require 'worried/transformers/new_relic_to_push_bullet'
require 'worried/outputs/push_bullet'
$LOAD_PATH.shift

require 'sinatra'
include Worried

get '/status' do
  'ok'
end

post '/new_relic/push_bullet' do
  body = request.body.read
  data = Inputs::NewRelic.parse(body)
  transformed = Transformers::NewRelicToPushBullet.transform(data)
  Outputs::PushBullet.send_note transformed
  'ok'
end
