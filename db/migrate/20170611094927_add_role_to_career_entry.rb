class AddRoleToCareerEntry < ActiveRecord::Migration[5.1]
  def change
    add_column :career_entries, :role, :string
  end
end
