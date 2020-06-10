class Question < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  validates :text, :user, presence: true
  validates :text,  length: { maximum: 255 }

  before_destroy :destroy_empty_hashtags

  after_save_commit :create_hashtags

  private

  def find_hashtags
    "#{text} #{answer}".
      downcase.
      scan(HASHTAG_REGEXP).
      uniq.
      map do |hashtag|
        Hashtag.find_or_create_by(text: hashtag, slug: Hashtag.normalize_string(hashtag))
      end
  end

  def create_hashtags
    find_hashtags.each do |hashtag|
      hashtags = self.hashtags

      unless hashtags.include?(hashtag)
        self.hashtags << hashtag
      end
    end
  end
end