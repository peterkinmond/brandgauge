class AddRetweetCountToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :retweet_count, :integer, :default => 0
  end
end
