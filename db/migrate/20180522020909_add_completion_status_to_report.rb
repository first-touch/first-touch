class AddCompletionStatusToReport < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :completion_status, :text
  end
end
