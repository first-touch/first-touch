class AddEmailTemplates < ActiveRecord::Migration[5.2]
  create_table :email_templates do |t|
    t.string :ref
    t.string :reply_to
    t.string :robot
    t.string :subject
    t.text :body
    t.timestamps null: false
  end

  add_index :email_templates, :ref
end
