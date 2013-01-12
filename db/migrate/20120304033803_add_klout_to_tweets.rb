class AddKloutToTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :klout_score
    add_column :tweets, :klout_score, :float
  end
end
