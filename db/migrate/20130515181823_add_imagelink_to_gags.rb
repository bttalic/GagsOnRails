class AddImagelinkToGags < ActiveRecord::Migration
  def change
    add_column :gags, :imagelink, :string
  end
end
