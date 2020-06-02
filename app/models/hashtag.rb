class Hashtag < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged

  has_many :question_hashtags
  has_many :questions, through: :question_hashtags

  def self.create_hashtag(text, question)
    hashtag_ru = Hashtag.find_by(text: translit_ru)
    hashtag_eng = Hashtag.find_by(text_eng: translit_eng)

    if hashtag_ru && hashtag_eng.nil?
      unless text_russian?
        hashtag_ru.update(text_eng: text)
      end
      hashtag_ru.questions << question
    elsif hashtag_eng && hashtag_ru.nil?
      if text_russian?
        hashtag_eng.update(text: text)
      end
      hashtag_eng.questions << question
    elsif hashtag_ru && hashtag_eng
      hashtag_ru.questions << question
    else
      if text_russian?
        new_hashtag = Hashtag.create(text: text, slug: translit_eng)
      else
        new_hashtag = Hashtag.create(text_eng: text, slug: text)
      end
      new_hashtag.questions << question
    end
  end

  private

  def translit_eng
    Translit.convert(text, :english)
  end

  def translit_ru
    Translit.convert(text, :russian)
  end

  def text_russian?
    text == translit_ru
  end
end
