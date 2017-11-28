class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :user, :question, :content, presence: true

end
