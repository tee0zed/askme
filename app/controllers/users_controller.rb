class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.sorted
    @hashtags = Hashtag.with_questions
  end

  def new
    redirect_to root_path, alert: "Вы уже залогинены" if current_user.present?

    @user = User.new
  end

  def create
    redirect_to root_path, alert: "Вы уже залогинены" if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: "Пользователь создан!"
    else
      flash.now[:alerts] = @user.errors.full_messages[0]
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Данные обновлены"
    else
      flash.now[:alerts] = @user.errors.full_messages[0]
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    if User.authenticate(@user.email, params[:password])
      @user.destroy

      session[:user_id] = nil
      redirect_to root_path, notice: "Пользователь успешно удален."
    else
      redirect_to edit_user_path, notice: "Неверный пароль."
    end
  end

  private

  def load_user
    @user ||= User.friendly.find(params[:id])
  end

  def authorize_user
    reject_user unless @user == current_user
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :name, :username, :avatar_url, :profilecolor
    )
  end
end
