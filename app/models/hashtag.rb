class Hashtag < ApplicationRecord
  has_many :question_hashtags
  has_many :questions, through: :question_hashtags

  extend FriendlyId
  friendly_id :text, use: :slugged

  def self.create_hashtag(text, question)
    hashtag = Hashtag.find_by(text: normalize_hashtag(text))
    if hashtag
      hashtag.questions << question
    else
      new_hashtag = Hashtag.create(text: normalize_hashtag(text))
      new_hashtag.questions << question
    end
  end

  def self.normalize_hashtag(text)
    text.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end
