class Gagreport < ActiveRecord::Base
	attr_accessible :report_type, :reported_id, :reporter_id

	belongs_to :reporter, class_name: "User"
	belongs_to :reported, class_name: "Gag"

	validates :reporter_id, presence: true
	validates :reported_id, presence: true
end
