class Hashtag < ApplicationRecord
  extend FriendlyId
  friendly_id :slug

  has_many :question_hashtags
  has_many :questions, through: :question_hashtags

  scope :sorted, -> { order(:created_at) }

  def self.create_hashtag(text, question)
    hashtag = Hashtag.find_or_create_by(text: text, slug: Hashtag.normalize_string(text))
    hashtag.questions << question unless hashtag.questions.include?(question)
  end

  def self.normalize_string(text)
    text.to_slug.normalize.to_s
  end
end