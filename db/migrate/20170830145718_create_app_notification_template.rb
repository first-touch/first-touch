class CreateAppNotificationTemplate < ActiveRecord::Migration[5.1]
  def change
    create_table :app_notification_templates do |t|
      t.string :ref
      t.string :available_fields
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
