# worried_app.rb
 
require 'rack'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'worried'
require 'worried/push_bullet'
require 'worried/new_relic'
$LOAD_PATH.shift

require 'sinatra'

get '/status' do
  'ok'
end

post '/new_relic/push_bullet' do
  body = request.body.read
  data = Worried::NewRelic.parse(body)
  if data.keys.include?('short_description')
    title = data['short_description']
    message =
      data['long_description'] << '\n\n' <<
      data['created_at']
  else
    title = 'Unknown message'
    message = data
  end
  Worried::PushBullet.send_note title, message
  'ok'
end