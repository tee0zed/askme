class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/' \
        '71269686e0f757ddb4f73614f43ae445?s=100'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user  =   User.new(
      name: 'Taras',
      username: 'tee_zed',
      avatar_url: 'https://ru.gravatar.com/userimage/185289849/260b9a7c24f5c9bd56b2e321993ecfd6.jpeg'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
    ]

    @new_question = Question.new
  end
end
