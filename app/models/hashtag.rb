class Hashtag < ApplicationRecord
  has_many :question_hashtags
  has_many :questions, through: :question_hashtags

  extend FriendlyId
  friendly_id :text, use: :slugged

  def self.create_hashtag(text, question)
    hashtag = Hashtag.find_by(text: text)
    if hashtag
      hashtag.questions.create(question_id: question)
    else
      new_hashtag = Hashtag.create(text: text)
      new_hashtag.questions << question
    end
  end
end
