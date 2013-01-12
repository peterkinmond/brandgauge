class AddUniqueIndexOnBrandName < ActiveRecord::Migration
  def up
    add_index :brands, :name, :unique => true
  end

  def down
    remove_index :brands, :name
  end
end
