module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present? && user
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
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

  def container_color
    return current_user.profilecolor if current_user
    '#4f8bc0'
  end
end
