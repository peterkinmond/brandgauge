class AddIndexToTweetCampaignId < ActiveRecord::Migration
  def change
    add_index :tweets, :campaign_id
  end
end
