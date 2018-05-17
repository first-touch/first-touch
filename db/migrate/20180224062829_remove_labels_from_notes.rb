class RemoveLabelsFromNotes < ActiveRecord::Migration[5.1]
  def change
    remove_column :notes, :labels
  end
end
