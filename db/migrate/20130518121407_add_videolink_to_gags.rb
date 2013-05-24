class AddVideolinkToGags < ActiveRecord::Migration
  def change
    add_column :gags, :videolink, :string
  end
end
