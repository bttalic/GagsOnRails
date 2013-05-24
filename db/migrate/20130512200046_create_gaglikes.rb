class CreateGaglikes < ActiveRecord::Migration
  def change
    create_table :gaglikes do |t|
      t.integer :liker_id
      t.integer :liked_id


      t.timestamps
    end
    
    add_index :gaglikes, :liker_id
    add_index :gaglikes, :liked_id
    add_index :gaglikes, [:liker_id, :liked_id], unique: true
  end
end
