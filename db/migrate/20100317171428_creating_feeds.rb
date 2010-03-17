class CreatingFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string   :channel_name
      t.string   :channel_link
      t.string   :item_title_selector
      t.string   :item_description_selector
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :feeds
  end
end
