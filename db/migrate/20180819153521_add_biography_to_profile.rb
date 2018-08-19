class AddBiographyToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :personal_profiles, :biography, :text
  end
end
