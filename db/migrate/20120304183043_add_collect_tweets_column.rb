class AddCollectTweetsColumn < ActiveRecord::Migration
  def up
    add_column :campaigns, :collect_tweets, :boolean, :default => true
  end

  def down
    remove_column :campaigns, :collect_tweets
  end
end
