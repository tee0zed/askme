module QuestionsHelper
  def link_to_question_author(question)
    return link_to(question.author&.username, user_path(question.author), class: "author-link") if question.author.present?
    "Аноним"
  end

  def get_hashtags(text)
    text.gsub(Question::HASHTAG_REGEXP).map do |hashtag_string|
      hashtag = Hashtag.find_by(text: hashtag_string.downcase)
      link_to(hashtag_string, hashtag_path(hashtag), class: 'author-link')
    end
  end
end
