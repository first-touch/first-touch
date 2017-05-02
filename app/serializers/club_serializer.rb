class ClubSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :country_code, :stadium_name,
             :date_founded, :twitter_handle, :website, :home_kit_color,
             :away_kit_color, :third_kit_color, :email, :phone_number,
             :facebook_link, :history
end
