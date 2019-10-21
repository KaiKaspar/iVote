class Poll < ApplicationRecord
  belongs_to :user

  has_many :votes
  has_many :users, through: :votes
  has_many :comments



end
