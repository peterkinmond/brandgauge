module BrandGauge
  class TwitterStream
    def initialize
      @tweet_handler = TweetHandler.new
    end

    def consume
      keywords = keywords_to_track
      Rails.logger.info("Starting to stream for #{keywords.inspect}")
      TweetStream::Client.new.track(*keywords) do |tweet|
        @tweet_handler.process(tweet)
      end
    end

    def keywords_to_track
      Brand.all_brand_names.map(&:downcase) + Campaign.all_hashtags
    end
  end
end
