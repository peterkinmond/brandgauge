class AddUserIdToTweetsTable < ActiveRecord::Migration
  def change
    add_column :tweets, :user_id, :string
  end
end
