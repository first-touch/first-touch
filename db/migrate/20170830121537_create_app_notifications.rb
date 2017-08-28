class CreateAppNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :app_notifications do |t|
      t.references :user, index: true
      t.string :title
      t.text :content
      t.boolean :read

      t.timestamps null: false
    end
    add_foreign_key :app_notifications, :users
  end
end
