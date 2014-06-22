class Worried::App

  def call(env)
    request = Rack::Request.new(env)
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
    successful_response
  end

  private

  def successful_response
    ['200', {'Content-Type' => 'text/html'}, ['ok']]
  end
end
