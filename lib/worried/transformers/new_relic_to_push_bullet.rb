module Worried
  module Transformers

    class NewRelicToPushBullet

      # @param new_relic_data [Hash] data from Inputs::NewRelic
      # @return [Hash] data for Outputs::PushBullet
      def self.transform(new_relic_data)
        if new_relic_data.keys.include?('short_description')
          title = new_relic_data['short_description']
          message =
            new_relic_data['long_description'] << '\n\n' <<
            new_relic_data['created_at']
        else
          title = 'Unknown message'
          message = new_relic_data
        end
        {
          title: title,
          body: message
        }
      end
    end
  end
end
