class AddVoteSignToGaglikes < ActiveRecord::Migration
  def change
    add_column :gaglikes, :vote_sign, :integer
  end
end
