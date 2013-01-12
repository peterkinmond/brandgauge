module BrandGauge::Jobs
  class EnrichTweet
    @queue = :enrich_tweets

    attr_reader :klout, :sentiment
    def initialize
      @sentiment_analyzer = BrandGauge::SentimentCalculator.new
      @klout_caclculator = BrandGauge::KloutCalculator.new
    end

    def self.perform(raw_tweet_id)
      EnrichTweet.new.perform(JSON.parse(RawTweet.find(raw_tweet_id).content))
    end

    def perform(raw_tweet)
      @tweet = raw_tweet
      if @tweet["retweeted"]
        increment_retweet_count
      else
        add_klout_score
        add_sentiment
        store_processed_tweet
      end
    end

    def add_klout_score
      @klout = @klout_caclculator.retreive(@tweet["user"]["screen_name"])
    end

    def add_sentiment
      @sentiment_analyzer.analyze(@tweet["text"])
    end

    def increment_retweet_count
      if tweet = Tweet.where(:tweet_id => @tweet["id_str"]).first
        tweet.increment(:retweet_count)
      end
    end

    def store_processed_tweet
      user = @tweet["user"]
      tweet = Tweet.create!(
        tweet_id: @tweet["id_str"],
        content: @tweet["text"],
        user_screen_name: user["screen_name"],
        user_real_name: user["name"],
        user_profile_image_url: user["profile_image_url"],
        user_id: user["id_str"],
        user_location: user["location"],
        followers_count: user["followers_count"],
        tweeted_at: @tweet["created_at"],
        klout_score: @klout, 
        sentiment: add_sentiment
      )

      associate_tweet(tweet)
    end

    def associate_tweet(tweet)
      Campaign.all.each { |campaign| campaign.associate_tweet(tweet) }
      Brand.all.each { |brand| brand.associate_tweet(tweet) }
    end

  end
end
