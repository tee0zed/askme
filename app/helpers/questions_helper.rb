module QuestionsHelper
  def questions_with_answers
    @questions.select { |q| q.answer.present? }.count
  end

  def questions_without_answers
    @questions.count - questions_with_answers
  end

  def question_author(question)
    return User.all.find(question.user_id).username if User.all.find(question.user_id).present?
    "Аноним"
  end

  def link_to_question_author(question)
    return user_path(User.all.find(question.user_id)) if User.all.find(question.user_id).present?
    root_path
  end
end
