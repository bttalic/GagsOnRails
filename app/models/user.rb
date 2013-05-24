class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :avatar, :theme
	has_attached_file :avatar, dependent: :destroy
	validates_attachment_content_type :avatar, 
	:content_type => /^image\/(png|gif|jpeg)/
	has_secure_password

	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id",
	class_name:  "Relationship",
	dependent:   :destroy
	has_many :followers, through: :reverse_relationships, source: :follower

	has_many :gags
	#gaglikes
	has_many :gaglikes, foreign_key: "liker_id"

	has_many :gagreports, foreign_key: "reporter_id"
	def voted?(gag)
		gaglikes.find_by_liked_id_and_liker_id(gag.id, self.id)
	end

	def liked?(gag)
		gaglikes.find_by_liked_id_and_vote_sign_and_liker_id(gag.id,"1",self.id)
	end

	def disliked?(gag)
		gaglikes.find_by_liked_id_and_vote_sign_and_liker_id(gag.id,"-1",self.id)
	end


	def like!(gag)
		if(!voted?(gag) )
			gaglikes.create!(liked_id: gag.id, vote_sign: "1")
		else
			if(voted?(gag) && liked?(gag)  )
				gaglikes.find_by_liked_id(gag.id).destroy
			else
				gaglike=gaglikes.find_by_liked_id(gag.id)
				gaglike.vote_sign="1"
				gaglike.save
			end
		end
	end
#gaglikes.find_by_liked_id(gag.id).destroy
def dislike!(gag)
	if(!voted?(gag) )
		gaglikes.create!(liked_id: gag.id, vote_sign: "-1")
	else
		if(voted?(gag) && disliked?(gag)  )
			gaglikes.find_by_liked_id(gag.id).destroy
		else
			gaglike=gaglikes.find_by_liked_id(gag.id)
			gaglike.vote_sign="-1"
			gaglike.save
		end
	end
end

def reported?(gag)
	gagreports.find_by_reporter_id_and_reported_id(self.id, gag.id)
end

def report(gag, type)
	gagreports.create!(reported_id:gag.id, report_type:type)
end


has_many :liked_gags, through: :gaglikes, source: "liked_id", dependent: :destroy



has_many :comments, foreign_key: "user_id", dependent: :destroy

before_save { |user| user.email = email.downcase }
before_save :create_remember_token

validates :name, presence: true, length: { maximum: 50 },
uniqueness: { case_sensitive: false }

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true,
format: { with: VALID_EMAIL_REGEX },
uniqueness: { case_sensitive: false }

validates :password, presence: true, length: { minimum: 6 }
validates :password_confirmation, presence: true

def feed
	Micropost.from_users_followed_by(self)
end

def feed2
	Gag.from_users_followed_by(self)
end


def following?(other_user)
	relationships.find_by_followed_id(other_user.id)
end
def follow!(other_user)
	relationships.create!(followed_id: other_user.id)
end

def unfollow!(other_user)
	relationships.find_by_followed_id(other_user.id).destroy
end

private
def create_remember_token
	self.remember_token = SecureRandom.urlsafe_base64
end
end