class Hashtag < ApplicationRecord
  has_and_belongs_to_many :questions

  def self.create_hashtag(text, question)
    hashtag = Hashtag.find_by(text: text)
    if hashtag
      hashtag.questions << question
    else
      new_hashtag = Hashtag.create(text: text)
      new_hashtag.questions << question
    end
  end
end
