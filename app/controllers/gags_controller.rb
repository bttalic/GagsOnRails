class GagsController < ApplicationController
 before_filter :signed_in_user, :except=>[:epic, :rising, :hatched, :show]
 # before_filter :correct_user,   only: :destroy


 def new
  @gag=Gag.new
end

def new2
  @gag=Gag.new
end

def new3
  @gag=Gag.new
end

def show
  @gag=Gag.find(params[:id])
  @comments=Comment.order('created_at DESC').find_all_by_gag_id(params[:id])
end

def create
  @gag = current_user.gags.build(params[:gag])
  @gag.votes_up=1
  @gag.votes=1
  @gag.ratio=1
  if @gag.save
    flash[:success] = "Awwwwwww Yeah! Thanks for the smiles"
    current_user.like!(@gag)
    redirect_to current_user
  else
    if request.referer.include?("uploadvideo")
      render 'new3'
    elsif request.referer.include?("uploadwithimage")
      render 'new2'
    else
      render 'new'
    end

  end
end

def destroy
  flash[:success] = "Gag deleted!"
  @gag=Gag.find(params[:id]).destroy
  redirect_to request.referer
end

def epic
  @epic=Gag.paginate(page: params[:page], :per_page=>100).find(:all, :conditions=>['votes>=200 and ratio>=0.3'])
  if signed_in?
  getRecommends
  getMostliked
end
end

def rising
  @rising=Gag.paginate(page: params[:page], :per_page=>100).find(:all, :conditions=>['(votes<200 and votes>=100 and ratio>0.15) '])
  if signed_in?
  getRecommends
  getMostliked
end
end

def hatched
  @hatched=Gag.paginate(page: params[:page], :per_page=>100).find(:all, :conditions=>['ratio<0.15 or votes<100 '])
  if signed_in?
  getRecommends
  getMostliked
end
end

def getMostliked
  @mostliked=Gag.find(:all, :order => "votes_up desc", :limit => 5)
end

def getRecommends
  gaglikes=current_user.gaglikes
  liked_ids=gaglikes.pluck(:liked_id)
  others=Gaglike.find_all_by_liked_id_and_vote_sign(liked_ids, "1")
  others_ids=Array.new
  others.first(10).each do |gag|
    if gag.liker_id!=current_user.id
      others_ids.push(gag.liker_id)
    end
  end
  @recommends=User.find_all_by_id(others_ids)
end

private

def correct_user
  @gag=Gag.find(params[:id])
  redirect_to(root_url) unless current_user?(@gag.user)
end

end
