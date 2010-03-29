Factory.define :feed do |f|
  f.channel_name 'Weatherdiff'
  f.channel_link 'www.weatherdiff.com'
  f.item_title_selector 'p:nth-child(3)'
  f.item_description_selector '#location_list'
end
