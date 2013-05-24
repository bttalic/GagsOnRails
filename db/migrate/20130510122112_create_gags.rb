class CreateGags < ActiveRecord::Migration
  def change
    create_table :gags do |t|
      t.string :title
      t.integer :user_id
      t.integer :votes
      t.integer :votes_up
      t.float :ratio

      t.timestamps
    end
    add_index :gags, [:user_id, :created_at];
  end
end
