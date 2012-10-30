class UsersController < ApplicationController
  
  def new
    @user = User.new
    @page_title = "Sign up for kids craft boxes delivered monthly to your door"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Awesome, thanks for signing up"
    else
      render "new"
    end
  end
  
end
