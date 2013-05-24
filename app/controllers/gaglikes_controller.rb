class GaglikesController < ApplicationController
	before_filter :signed_in_user
	respond_to  :js
	def create
		@gag=Gag.find(params[:gaglike][:liked_id])
		@vote=(params[:gaglike][:vote_sign]).to_f
		if !current_user.voted?(@gag) || (current_user.liked?(@gag) && @vote==-1) || (current_user.disliked?(@gag) && @vote==1)
			@gag.votes=@gag.votes+1
			@gag.votes_up=@gag.votes_up+@vote
			if @gag.votes>0
				@gag.ratio=@gag.votes_up.to_f/@gag.votes
			else
				@gag.ratio=0
			end
			@gag.save
		else
			@gag.votes=@gag.votes-1
			@gag.votes_up=@gag.votes_up-@vote
			if @gag.votes>0
				@gag.ratio=@gag.votes_up.to_f/@gag.votes
			else
				@gag.ratio=0
			end
			@gag.save
		end
		if @vote==1
			current_user.like!(@gag)
		else
			current_user.dislike!(@gag)
		end
		respond_with @gag
	end

	def destroy
		@gaglike=Gaglike.find(params[:id])
		@gag=Gag.find(gaglike.liked_id)
		@vote=@gaglike.vote_sign

		@gag.votes=@gag.votes-1
		@gag.votes_up=@gag.votes_up-gaglike.vote_sign
		if @gag.votes>0
			@gag.ratio=@gag.votes_up.to_f/@gag.votes
		else
			@gag.ratio=0
		end
		@gag.save
		if @vote==1
			current_user.like!(@gag)
		else
			current_user.dislike!(@gag)
		end
		respond_with @gag
	end

	

	def changeVote
		@gag=Gag.find(params[:gaglike][:liked_id])
		@gag.votes=@gag.votes+1
		@gag.votes_up=@gag.votes_up+(params[:gaglike][:vote_sign]).to_f
		@gag.save
		respond_with @gag
	end

end