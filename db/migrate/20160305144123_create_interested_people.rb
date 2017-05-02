class CreateInterestedPeople < ActiveRecord::Migration[4.2]
  def change
    create_table :interested_people do |t|
      t.string :email
      t.string :name

      t.timestamps null: false
    end
  end
end
