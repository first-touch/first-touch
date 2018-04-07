class AddNationToCompetition < ActiveRecord::Migration[5.1]
  def change
    add_column :competitions, :nation, :string
  end
end
