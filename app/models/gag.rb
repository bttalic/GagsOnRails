class Gag < ActiveRecord::Base
  attr_accessible  :title, :image, :votes_up, :imagelink, :videolink
  #:ratio, :title, :user_id, :votes, :votes_up, :image
  has_attached_file :image, dependent: :destroy
  validates_attachment_content_type :image, 
  :content_type => /^image\/(png|gif|jpeg)/
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 },
  uniqueness: { case_sensitive: false }

  has_many :comments, foreign_key: "gag_id", dependent: :destroy

  validate :at_least_one
  validate :videolink_format
  validate :imagelink_format

  def at_least_one
    if [self.image, self.imagelink, self.videolink].compact.size == 0
      errors[:base] << ("You must add a Gag")
    end
  end 

  def videolink_format
    if self.videolink?
     if (self.videolink.include?("youtube") && self.videolink.include?("v="))==false
      errors[:base] << ("Invalid video link")
    else
      self.videolink="http://www.youtube.com/embed/"+self.videolink[self.videolink.index("v=")+2, self.videolink.length]
    end
  end
end

def imagelink_format
  if self.imagelink?

    if( self.imagelink.include?(".gif") || self.imagelink.include?(".png") || self.imagelink.include?(".jpg") || self.imagelink.include?(".jpeg") )==false
      errors[:base] << ("Invalid image link")
    end
  end
end

#gaglike
has_many :gaglikes, foreign_key: "liked_id", dependent: :destroy
has_many :gagreports, foreign_key: "reported_id", dependent: :destroy

default_scope order: 'gags.created_at DESC'



def self.from_users_followed_by(user)
  followed_user_ids = "SELECT followed_id FROM relationships
  WHERE follower_id = :user_id"
  where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
   user_id: user.id)
end



end
