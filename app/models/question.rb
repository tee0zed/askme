class Question < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hashtags
  has_many :hashtags, through: :question_hashtags

  validates :text, :user, presence: true
  validates :text,  length: { maximum: 255 }

  before_destroy :destroy_empty_hashtags

  after_save_commit :find_hashtags

  private

  def find_hashtags
    "#{text} #{answer}".scan(HASHTAG_REGEXP).uniq.map do |hashtag|
      hashtag_text = hashtag.downcase
      question = self

      Hashtag.create_hashtag(hashtag_text, question)
    end
  end

  def destroy_empty_hashtags
    self.hashtags.each do |hashtag|
      questions = hashtag.questions

      hashtag.destroy if questions.size == 1 && questions.first == self
    end
  end
end
