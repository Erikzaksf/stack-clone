class Question < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  has_many :answers
  validates :user, :title, :content, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :today_total, -> { where("created_at >=?", Time.now.beginning_of_day).length }
end
