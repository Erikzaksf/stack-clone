class Question < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  has_many :answers
  validates :user, :title, :content, presence: true


end
