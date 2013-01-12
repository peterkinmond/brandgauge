class AddCollectTweetsToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :collect_tweets, :boolean, :default => true
  end
end
