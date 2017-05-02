class AddRemainingFieldsToPersonalProfile < ActiveRecord::Migration[4.2]
  def change
    add_column :personal_profiles, :place_of_birth, :string
    add_column :personal_profiles, :weight, :float
    add_column :personal_profiles, :height, :float
    add_column :personal_profiles, :preferred_foot, :string

    remove_column :personal_profiles, :summary, :string
    remove_column :personal_profiles, :achievements, :string, array: true
    remove_column :personal_profiles, :languages, :string, array: true
  end
end
