class AddEmotionsToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :sadness, :float
    add_column :microposts, :joy, :float
    add_column :microposts, :fear, :float
    add_column :microposts, :disgust, :float
    add_column :microposts, :anger, :float
  end
end
