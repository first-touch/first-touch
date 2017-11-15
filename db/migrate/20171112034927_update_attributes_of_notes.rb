class UpdateAttributesOfNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :content, :text
    rename_column :notes, :tags, :labels
  end
end
