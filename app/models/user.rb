class User < ApplicationRecord
  has_many :questions
  has_many :votes
  has_many :answers
  attr_accessor :password
  validates_confirmation_of :password
  validates :user_name, :email, :presence => true, :uniqueness => true
  before_save :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
  end

  def self.authenticate(email, password)
    user = User.find_by "email = ?", email
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def question_upvote(question)
    Vote.where("user_id = ? AND question_id = ? AND is_upvote = true", self.id, question.id).take
  end

  def has_downvoted_question?(question)
    return Vote.where("user_id = ? AND question_id = ? AND is_upvote = false", self.id, question.id).any?
  end
end
