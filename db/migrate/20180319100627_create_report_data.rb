class CreateReportData < ActiveRecord::Migration[5.1]
  def change
    create_table :report_data do |t|
      t.references :report, foreign_key: true
      t.json :meta_data
      t.integer :version

      t.timestamps
    end
  end
end
