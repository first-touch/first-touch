class CreateClubs < ActiveRecord::Migration[5.0]
  def change
    create_table :clubs do |t|
      t.integer :account_owner_id
      t.string :name
      t.string :city
      t.string :country_code
      t.string :stadium_name
      t.date :date_founded
      t.string :twitter_handle
      t.string :website
      t.text :history
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :facebook_link
      t.string :home_kit_color
      t.string :away_kit_color
      t.string :third_kit_color

      t.timestamps
    end
  end
end
