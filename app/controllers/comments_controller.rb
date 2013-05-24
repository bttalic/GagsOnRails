class CommentsController < ApplicationController
	before_filter :signed_in_user
	respond_to  :js

def new
	Comment.new
end

def create
  @comment = current_user.comments.build(params[:comment])
  if @comment.save
  	respond_with @comment
  end
end

def destroy
  flash[:success] = "Comment deleted!"
  @comment=Comment.find(params[:id]).destroy
  redirect_to request.referer
end

end