class CreateCompetition < ActiveRecord::Migration[5.1]
  def change
    create_table :competitions do |t|
      t.string :name
      t.integer :competition_type
      t.string :sponsor
      t.timestamps
    end
  end
end
