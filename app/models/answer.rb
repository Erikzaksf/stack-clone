class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :user, :question, :content, presense: true
  
end
