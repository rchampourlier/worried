require 'json'

module Worried
  module Inputs

    class NewRelic

      # @param body [String] the request's body
      def self.parse(body)
        payload = CGI.parse(body).values.flatten.first
        JSON.parse payload
      end
    end
  end
end
