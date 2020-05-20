class SessionsController < ApplicationController
  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user.present?
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Вы успешно залогинились'
    else
      flash.now.alert = 'Неправильные данные'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Вы разлогинились."
  end
end
