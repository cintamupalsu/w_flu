class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user

      #remember user #See session helper
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)

      redirect_back_or user
    else
      flash.now[:danger] = 'メール/パスワードの組み合わせが無効です'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
