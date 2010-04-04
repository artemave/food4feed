require 'open-uri'
require 'rss/2.0'
require 'rss/maker'

class Feed < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    channel_name              :string
    channel_link              :string
    item_container_selector   :string
    item_title_selector       :string
    item_description_selector :string
    last_retreived_items      :serialized, :class => Array
    last_build_date           :timestamp
    timestamps
  end

  # XXX meant to be attr_reader but sadly hobo does not support this
  attr_accessor :result_url, :type => :string

  FEED_PATH_PREFIX = "/public/feeds"
  FEED_ROOT_PATH = RAILS_ROOT + FEED_PATH_PREFIX

  def self.make_sure_feed_path_exists
    # TODO emulate mkdir -p
    Dir.mkdir(FEED_ROOT_PATH) unless File.exists?(FEED_ROOT_PATH)
  end

  def refresh
    doc = Nokogiri::HTML(open(channel_link))

    items = []
    doc.css(item_container_selector).each do |item|
      items << {
        :title => item.at_css(item_title_selector).text.strip || 'New content',
        :description => item.at_css(item_description_selector).text || 'none',
      }
    end

    new_items = items - last_retreived_items.map {|i| i.except(:date)}

    return if new_items.empty?

    # inject date field
    new_items.map! {|i| i.update :date => Time.now}

    # provide at least 10 items in the feed:
    # if there aren't enough new ones, also take from the most recent of the old ones
    if (tail = 10 - new_items.length) > 0
      new_items += last_retreived_items.reverse.take(tail)
    end

    store(generate(new_items, self.last_build_date = Time.now))

    self.last_retreived_items = new_items
    save!
  end

  def result_url
    "#{FEED_PATH_PREFIX}/#{file_name}"
  end

  # emulates default value of [] for last_retreived_items
  def last_retreived_items
    read_attribute(:last_retreived_items) || []
  end

  # XXX helps ':serialized' to do the job
  def last_retreived_items=(items)
    write_attribute(:last_retreived_items, items.is_a?(String) ? eval(items) : items)
  end

  # make sure channel_link always starts with http
  def channel_link= (url)
    write_attribute(:channel_link, url =~ /^http/ ? url : "http://#{url}")
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

  private

  def store(feed)
    File.open("#{FEED_ROOT_PATH}/#{file_name}", 'w') do |f|
      f.write(feed)
    end
  end

  def file_name
    "#{id}.xml"
  end

  def generate(items, last_build_date)
    RSS::Maker.make('2.0') do |m|
      m.channel.title = channel_name
      m.channel.link = channel_link
      m.channel.description = 'food4feed generated feed'
      m.channel.lastBuildDate = last_build_date

      m.items.do_sort = true

      items.each do |i|
        item = m.items.new_item
        item.title = i[:title]
        item.description = i[:description]
        item.date = i[:date]
      end
    end
  end
end
