class AddUserLocationToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :user_location, :string
  end
end
