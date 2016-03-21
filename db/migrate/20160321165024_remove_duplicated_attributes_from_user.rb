class RemoveDuplicatedAttributesFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :birthday
    remove_column :users, :nationality_country_code
    remove_column :users, :residence_country_code
  end
end
