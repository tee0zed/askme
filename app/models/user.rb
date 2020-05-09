require 'openssl'

class User < ApplicationRecord

  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  before_validation :username_downcase
  before_save :encrypt_password

  validates :email, :username, presence: true
  validates :email, uniqueness: true

  validates :username,  length: { maximum: 40 }
  validates :username, format: { with: /\A[a-z0-9_]+\z/i }

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "неправильного формата"}

  attr_accessor :password

  validates :password, presence: true, on: :create, confirmation: true

  private

  def username_downcase
    self.username = username.downcase
  end

  def encrypt_password
    if self.password.present?

      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end
end

def self.authenticate(email, password)
  user = find_by(email: email)

  return nil unless user.present?

  hashed_password = User.hash_to_string(
    OpenSSL::PKCS5.pbkdf2_hmac(
      password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
    )
  )

  return user if user.password_hash == hashed_password

  nil
end
