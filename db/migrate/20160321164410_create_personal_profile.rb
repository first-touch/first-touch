class CreatePersonalProfile < ActiveRecord::Migration
  def change
    create_table :personal_profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :birthday
      t.string :nationality_country_code
      t.string :residence_country_code
      t.string :summary
      t.string :achievements, array: true, default: []
      t.string :languages, array: true, default: []

      t.timestamps null: false
    end
  end
end
