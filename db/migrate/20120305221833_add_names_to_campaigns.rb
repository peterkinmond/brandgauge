class AddNamesToCampaigns < ActiveRecord::Migration
  def change
    Campaign.all.each{|c| c.update_attribute(:name, c.keyphrase)}
  end
end
