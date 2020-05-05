class User < ApplicationRecord
  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  validates :username,  length: { maximum: 40 }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, format: { with: /\A[a-zA-Z0-9_]+\z/i }
end
