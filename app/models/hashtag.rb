class Hashtag < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged

  has_many :question_hashtags
  has_many :questions, through: :question_hashtags

  def self.create_hashtag(text, question)
    hashtag_ru = Hashtag.find_by(text: translit_ru(text))
    hashtag_eng = Hashtag.find_by(text_eng: translit_eng(text))

    if hashtag_ru && hashtag_eng.nil?
      unless text_russian?(text)
        hashtag_ru.update(text_eng: text)
      end
      hashtag_ru.questions << question
    elsif hashtag_eng && hashtag_ru.nil?
      if text_russian?(text)
        hashtag_eng.update(text: text)
      end
      hashtag_eng.questions << question
    elsif hashtag_ru && hashtag_eng
      hashtag_ru.questions << question
    else
      if text_russian?(text)
        new_hashtag = Hashtag.create(
          text: text,
          slug: translit_eng(text)[1..-1]
        )
      else
        new_hashtag = Hashtag.create(
          text_eng: text,
          slug: text[1..-1]
        )
      end
      new_hashtag.questions << question
    end
  end

  def self.translit_eng(text)
    "#" + Translit.convert(text[1..-1], :english)
  end

  def self.translit_ru(text)
    "#" + Translit.convert(text[1..-1], :russian)
  end

  def self.text_russian?(text)
    text == translit_ru(text)
  end
end
