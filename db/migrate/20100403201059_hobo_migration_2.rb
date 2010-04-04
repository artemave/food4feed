class HoboMigration2 < ActiveRecord::Migration
  def self.up
    add_column :feeds, :item_container_selector, :string
    add_column :feeds, :last_retreived_items, :text
    add_column :feeds, :last_build_date, :timestamp
  end

  def self.down
    remove_column :feeds, :item_container_selector
    remove_column :feeds, :last_retreived_items
    remove_column :feeds, :last_build_date
  end
end
