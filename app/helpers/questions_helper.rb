module QuestionsHelper
  def link_to_question_author(question)
    return link_to(question.author&.username, user_path(question.author), class: "author-link") if question.author.present?
    "Аноним"
  end
end
