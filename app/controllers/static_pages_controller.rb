class StaticPagesController < ApplicationController
	def home
		if signed_in?
			@micropost = current_user.microposts.build
			@feed_items = current_user.feed.paginate(page: params[:page])
			@feed_items2= current_user.feed2.paginate(page: params[:page])
		end
	end

	def help
	end

	def about
	end

	def contact
	end

	def search
		@search=params[:term]
		search='%'+params[:term]+'%'
		@users=User.paginate(page: params[:page]).where('name like ?',search).all
		@gags=Gag.paginate(page: params[:page]).where('title like ?',search).all
		search='%#'+params[:term]+'%'
		@microposts=Micropost.paginate(page: params[:page]).where('content like ?', search).all

	end
end
