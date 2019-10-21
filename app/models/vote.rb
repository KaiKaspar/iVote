class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :poll

  has_many :comments
end
