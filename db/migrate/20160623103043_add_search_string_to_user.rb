class AddSearchStringToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :search_string, :text
  end
end
