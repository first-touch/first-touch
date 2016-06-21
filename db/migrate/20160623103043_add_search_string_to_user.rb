class AddSearchStringToUser < ActiveRecord::Migration
  def change
    add_column :users, :search_string, :text
  end
end
