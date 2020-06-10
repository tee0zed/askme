class Hashtag < ApplicationRecord
  extend FriendlyId
  friendly_id :slug

  has_many :question_hashtags
  has_many :questions, through: :question_hashtags

  scope :with_questions, -> do
    left_outer_joins(:question_hashtags).where.not(question_hashtags: { id: nil }).distinct.order(:created_at)
  end

  def self.normalize_string(text)
    text.to_slug.normalize.to_s
  end
end
