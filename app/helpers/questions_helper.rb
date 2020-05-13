module QuestionsHelper
  def question_author(question)
    return question.author.username if question.author.present?
    "Аноним"
  end

  def link_to_question_author(question)
    return user_path(question.author) if question.author.present?
    root_path
  end
end
