class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :brand_id
      t.string :keyphrase

      t.timestamps
    end
  end
end
