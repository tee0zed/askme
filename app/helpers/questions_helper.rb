module QuestionsHelper
  def link_to_question_author(question)
    return link_to(question.author&.username, user_path(question.author), class: "author-link") if question.author.present?
    "Аноним"
  end

  def text_with_hashtags(text)
    text.gsub(Question::HASHTAG_REGEXP) do |hashtag_string|
      hashtag = Hashtag.find_by(text: hashtag_string.downcase)
      link_to(hashtag_string, hashtag, class: "link-author")
    end
  end
end
