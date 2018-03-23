class CreateAttachmentItems < ActiveRecord::Migration[5.1]
  def change
    create_table :attachment_items do |t|
      t.integer :attachment_id
      t.integer :report_datum_id

      t.timestamps
    end
  end
end
