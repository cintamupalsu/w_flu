class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions do |t|
      t.float :lat
      t.float :lon
      t.references :user, null: false, foreign_key: true
      t.datetime :recdate
      t.integer :power

      t.timestamps
    end
    add_index :positions, [:recdate, :user_id]
  end
end
