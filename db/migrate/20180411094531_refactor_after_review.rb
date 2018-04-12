class RefactorAfterReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :meta_data, :json
    drop_table :report_data
    drop_table :attachment_items
    add_index :attachments, :report_id
    add_reference :reports, :attachments, foreign_key: true

  end
end
