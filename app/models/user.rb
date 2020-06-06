require 'openssl'

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  USERNAME_REGEXP = /\A[a-z0-9_]+\z/i
  PROFILECOLOR_REGEXP = /\A#([\h]{3}){1,2}\z/

  attr_accessor :password
  
  has_many :questions, dependent: :destroy

  scope :sorted, -> { order(:created_at) }

  before_validation :username_downcase
  before_save :encrypt_password

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :username,
            uniqueness: true,
            length: { maximum: 40 },
            format: { with: USERNAME_REGEXP }

  validates :avatar_url,
            format: { with: URI::regexp(%w(http https)) },
            allow_blank: true

  validates :profilecolor,
            format: { with: PROFILECOLOR_REGEXP },
            if: :profilecolor

  validates :password, presence: true,
            on: [:create, :destroy],
            confirmation: true

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.destroy(user)
    user.destroy
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
end
