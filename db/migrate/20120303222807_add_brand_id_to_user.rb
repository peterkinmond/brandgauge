class AddBrandIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :brand_id, :integer
  end
end
