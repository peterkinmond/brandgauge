class AddHashtagToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :hashtag, :string
  end
end
