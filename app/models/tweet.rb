class Tweet < ActiveRecord::Base
  validates_presence_of :content, :tweet_id, :user_screen_name, :user_real_name,
                        :user_profile_image_url, :followers_count, :tweeted_at,
                        :user_id, :followers_count
  belongs_to :campaign
end
