class AddRemainingPropertiesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :personal_profiles, :qualifications, :text
    add_column :personal_profiles, :affiliations, :text
    add_column :personal_profiles, :scouting_badges, :text
    add_column :personal_profiles, :scope_of_operation, :string, array: true, default: []
  end
end
