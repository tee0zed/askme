module QuestionsHelper
  def question_author(question)
    question.author&.username || "Аноним"
  end

  def link_to_question_author(question)
    return user_path(question.author) if question.author.present?
    nil
  end
end
