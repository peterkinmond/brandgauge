class Brand < ActiveRecord::Base
  validates_presence_of :name

  has_many :campaigns
  has_many :users
  has_many :tweets

  validates_uniqueness_of :name

  def self.all_brand_names
    Brand.where(:collect_tweets => true).map(&:name)
  end

  def associate_tweets
    Tweet.update_all("brand_id = #{self.id}", "content like '%#{brand_name}%'")
  end

  def associate_tweet(tweet)
    if tweet.content.include?(brand_name)
      tweet.update_attribute(:brand_id , self.id)
    end
  end

  def brand_name
    self.name.downcase.gsub(/\s/, "")
  end

  def sentiment_by_day
    raw_rows = Tweet.select('(SUM(sentiment)/COUNT(sentiment)) AS average_sentiment, DATE(tweeted_at) AS date, HOUR(tweeted_at) AS hour').
      where('sentiment <> 0').
      where(:brand_id => id).
      group('HOUR(tweets.tweeted_at)').
      order('tweets.tweeted_at')
    raw_rows.map do |raw_row|
      [
        Time.parse(raw_row.date.to_s + ' ' + raw_row.hour.to_s + ':00:00').strftime('%b %e %H:00'),
        raw_row.average_sentiment.to_f
      ]
    end
  end

  private :brand_name

end
