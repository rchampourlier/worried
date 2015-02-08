require 'uri'
require 'net/http'
require 'net/https'

module Worried
  module Outputs
    class PushBullet

      # POST https://api.pushbullet.com/v2/pushes
      #   - type=note
      #   - title
      #   - body
      #
      # @param attributes [Hash]
      #   - title [String], defaults to "No title"
      #   - content  [String], defaults to "No body"
      def self.send_note(title: "No title", body: "No body")

        uri = URI.parse 'https://api.pushbullet.com/v2/pushes'

        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(uri.path)
        request.basic_auth ENV['PUSHBULLET_API_KEY'], ''
        request.set_form_data({
          'type'  => 'note',
          'title' => title,
          'body'  => body
        })

        https.request(request)
      end
    end
  end
end
