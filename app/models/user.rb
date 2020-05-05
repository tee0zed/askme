class User < ApplicationRecord

  has_many :questions

  before_validation :username_downcase

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  validates :username,  length: { maximum: 40 }
  validates :username, format: { with: /\A[a-zA-Z0-9_]+\z/i }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def username_downcase
    self.username = username.downcase
  end
end
