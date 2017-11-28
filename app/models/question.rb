class Question < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  validates :user, :title, :content, presence: true


end
