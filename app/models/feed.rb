class Feed < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    channel_name              :string
    channel_link              :string
    item_title_selector       :string
    item_description_selector :string
    timestamps
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

end
