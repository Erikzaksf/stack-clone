class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :user, :question, :content, presence: true

  scope :today_total, -> { where("created_at >=?", Time.now.beginning_of_day).length }  

end
