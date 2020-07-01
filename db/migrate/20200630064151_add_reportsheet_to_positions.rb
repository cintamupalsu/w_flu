class AddReportsheetToPositions < ActiveRecord::Migration[6.0]
  def change
    add_reference :positions, :reportsheet, foreign_key: true
  end
end
