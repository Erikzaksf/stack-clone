class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  validates :user, presence: true
end
