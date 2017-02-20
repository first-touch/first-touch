class UpdateInterestedPerson < ActiveRecord::Migration[5.0]
  def change
    remove_column :interested_people, :name
    add_column :interested_people, :request, :string
  end
end
