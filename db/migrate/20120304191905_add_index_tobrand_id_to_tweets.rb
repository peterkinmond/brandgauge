class AddIndexTobrandIdToTweets < ActiveRecord::Migration
  def change
    add_index :tweets, :brand_id
  end
end
