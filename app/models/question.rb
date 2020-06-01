class Question < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_and_belongs_to_many :hashtags

  validates :text, :user, presence: true
  validates :text,  length: { maximum: 255 }

  before_destroy :destroy_empty_hashtags

  after_save :find_hashtags

  protected

  def has_hashtag?
    text.scan(/#[[:word:]-]+/).present?
  end

  private

  def find_hashtags
    if has_hashtag?
      text.scan(/#[[:word:]-]+/).each do |hashtag|
        hashtag_text = hashtag.downcase
        question = self

        Hashtag.create_hashtag(hashtag_text, question)
      end
    end
  end

  def destroy_empty_hashtags
    self.hashtags.each do |hashtag|
      hashtag.destroy if hashtag.questions.size == 1 && hashtag.questions.first == self
    end
  end
end
