require 'json'

module Worried
  module Inputs

    class NewRelic

      # @param body [String] the request's body
      def self.parse(body)
        JSON.parse body
      end
    end
  end
end
