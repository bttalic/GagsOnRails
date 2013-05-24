class GagreportsController < ApplicationController
	before_filter :signed_in_user
	respond_to  :js

	def create
		@gag=Gag.find(params[:gagreport][:reported_id])
		@gag_id=@gag.id
		@report_type=(params[:gagreport][:report_type])
		reports=Gagreport.find_all_by_reported_id_and_report_type(@gag.id,@report_type).count
		if reports.to_f>10
			@gag.destroy
		else
			current_user.report(@gag, @report_type)
		end
		respond_with @gag_id
	end


end