class CreateReportsheets < ActiveRecord::Migration[6.0]
  def change
    create_table :reportsheets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
