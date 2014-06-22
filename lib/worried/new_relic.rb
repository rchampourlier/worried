require 'json'

class Worried::NewRelic

  def self.parse(body)
    payload = CGI.parse(body).values.flatten.first
    JSON.parse payload
  end
end