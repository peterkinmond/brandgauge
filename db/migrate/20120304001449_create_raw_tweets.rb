class CreateRawTweets < ActiveRecord::Migration
  def change
    create_table :raw_tweets do |t|
      t.text :content

      t.timestamps
    end
  end
end
