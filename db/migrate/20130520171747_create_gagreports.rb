class CreateGagreports < ActiveRecord::Migration
	def change
		create_table :gagreports do |t|
			t.integer :reported_id
			t.integer :reporter_id
			t.integer :report_type

			t.timestamps
		end
		add_index :gagreports, :reported_id
		add_index :gagreports, :reporter_id
		add_index :gagreports, [:reporter_id, :reported_id], unique: true
	end
end
