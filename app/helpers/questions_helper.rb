module QuestionsHelper
  def link_to_question_author(question)
    return link_to(question.author&.username, user_path(question.author), class: "author-link") if question.author.present?
    "Аноним"
  end

  def text_with_hashtags(text)
    text.gsub(Question::HASHTAG_REGEXP) { |hashtag| link_to hashtag, hashtag_path(Hashtag.normalize_string(hashtag)), class: 'author-link' }.html_safe
  end
end
