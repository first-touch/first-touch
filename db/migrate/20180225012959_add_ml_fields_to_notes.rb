class AddMlFieldsToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :field_type, :integer, default: 0
    add_column :notes, :elements, :jsonb
  end
end
