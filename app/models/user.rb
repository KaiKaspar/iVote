class User < ApplicationRecord

  has_many :votes
  has_many :polls, through: :votes
  has_many :polls
  belongs_to :profile_picture

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  def followers
    Follower.where("followed_id = #{id}")
  end

  def following
    Follower.where("follower_id = #{id}")
  end

  def self.search(search)
    if search
      found = User.where(username: search)
      if found.empty?
        User.all
      else
        found
      end
    else
      User.all
    end
  end
end
