class CreateSessionPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :session_plans do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :tags, array: true

      t.timestamps
    end
  end
end
