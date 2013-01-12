module BrandGauge
  class TweetHandler
    def process(tweet)
      Rails.logger.info("processing tweet")
      raw_tweet = RawTweet.create!(:content => tweet.to_json)
      Resque.enqueue(BrandGauge::Jobs::EnrichTweet, raw_tweet.id)
    rescue => e
      Rails.logger.error("TWEET STREAM ERROR: An error occured processing tweet. Reason was: #{e.inspect}")
    end
  end
end
