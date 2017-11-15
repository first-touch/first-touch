class RenameSessionPlansToNotes < ActiveRecord::Migration[5.1]
  def change
    rename_table :session_plans, :notes
  end
end
