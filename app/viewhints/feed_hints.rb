class FeedHints < Hobo::ViewHints

  # model_name "My Model"
  field_names :item_title_selector => "Title", :item_description_selector => "Description"
  # field_help :field1 => "Enter what you want in this field"
  # children :primary_collection1, :aside_collection1, :aside_collection2
end
