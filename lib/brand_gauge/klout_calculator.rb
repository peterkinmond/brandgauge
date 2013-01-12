module BrandGauge
  class KloutCalculator
    def initialize
      if Rails.env.production?
        @klout_client = Klout::API.new('production_key')
      else
        @klout_client = Klout::API.new("fake_key")
      end
    end

    def retreive(user_name)
      klout = Rails.cache.fetch("Klout:#{user_name}") do
        begin
          response = @klout_client.klout(user_name)
          if response["status"] == 200
            klout = response["users"][0]["kscore"]
          end
          klout
        rescue => e
          Rails.logger.info { "Could not get Klout score for '#{user_name}' Reason was: '#{e.inspect}'. Klout response was: '#{response}'" }
          klout = 1
          klout
        end
      end
      klout
    end
  end
end
