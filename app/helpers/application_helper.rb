module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def sklonyator(num)
    digit = num % 10

    if num.digits[1] == 1
      'вопросов'
    elsif digit == 1
      'вопрос'
    elsif digit.between?(2, 4)
      'вопроса'
    else
      'вопросов'
    end
  end
end
