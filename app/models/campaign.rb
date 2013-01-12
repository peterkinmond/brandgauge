class Campaign < ActiveRecord::Base
  validates_presence_of :brand_id, :name

  belongs_to :brand
  has_many :tweets

  def self.all_hashtags
    self.where(:collect_tweets => true).map(&:hashtag).reject { |h| h.blank? }
  end

  def recent_tweets
    Tweet.where(:campaign_id => id).where('sentiment != 0').order('created_at DESC').limit(10)
  end

  def top_influencers
    Tweet.where(:campaign_id => id).order('klout_score desc').limit(20)
  end

  def sentiment_by_day
    raw_rows = Tweet.select('(SUM(sentiment)/COUNT(sentiment)) AS average_sentiment, DATE(tweeted_at) AS date, HOUR(tweeted_at) AS hour').
      where('sentiment <> 0').
      where(:campaign_id => id).
      group('HOUR(tweets.tweeted_at)').
      order('tweets.tweeted_at')
    raw_rows.map do |raw_row|
      [
        Time.parse(raw_row.date.to_s + ' ' + raw_row.hour.to_s + ':00:00').strftime('%b %e %H:00'),
        raw_row.average_sentiment.to_f
      ]
    end
  end

  def associate_tweets
    Tweet.update_all("campaign_id = #{self.id}", "content like '%#{brand_name}%' AND content like '%#{keyphrase.downcase}%'")
  end

  def associate_tweet(tweet)
    if tweet.content.match(Regexp.new(brand_name, true)) && !self.keyphrase.blank? && tweet.content.match(Regexp.new(keyphrase, true))
      Rails.logger.info("associating tweet to campaign: '#{self.id}'")
      tweet.update_attribute(:campaign_id, self.id)
    elsif !self.hashtag.blank? && tweet.content.match(Regexp.new(hashtag, true))
      Rails.logger.info("associating tweet to campaign: '#{self.id}'")
      tweet.update_attributes(:campaign_id => self.id, :brand_id => self.brand.id)
    end
  end

  def lift
    Tweet.select('SUM(sentiment) AS sentiment').where(:campaign_id => id).first.sentiment
  end

  def tweet_count_in_last_n_seconds(seconds = 3)
    Tweet.select('COUNT(tweet_id) AS count').
      where(:campaign_id => id).
      where("created_at > DATE_SUB(UTC_TIMESTAMP(), INTERVAL #{seconds} SECOND)").first.count
  end

  def tweets_in_last_n_seconds(seconds = 3)
    Tweet.where(:campaign_id => id).where("created_at > (UTC_TIMESTAMP() - INTERVAL #{seconds} SECOND)")
  end

  def brand_name
    self.brand.name.downcase.gsub(/\s/, "")
  end
  private :brand_name

end
