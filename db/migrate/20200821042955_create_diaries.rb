class CreateDiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :diaries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :note01
      t.date :day

      t.timestamps
    end
  end
end
