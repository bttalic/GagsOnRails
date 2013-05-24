class Comment < ActiveRecord::Base
  attr_accessible :content, :gag_id, :user_id

  belongs_to :user
  belongs_to :gag
  validates :user_id, presence: true
  validates :gag_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

end
