class ApplicationController < ActionController::Base
  #def hello
  #  render html: "hello, world!"
  #end
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
end
