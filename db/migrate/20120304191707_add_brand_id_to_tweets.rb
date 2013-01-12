class AddBrandIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :brand_id, :integer
  end
end
