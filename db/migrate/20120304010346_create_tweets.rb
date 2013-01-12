class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string   :content
      t.string   :tweet_id
      t.string   :user_screen_name
      t.string   :user_real_name
      t.string   :user_profile_image_url
      t.integer  :followers_count
      t.integer  :sentiment
      t.integer  :klout_score
      t.datetime :tweeted_at

      t.timestamps
    end
  end
end
