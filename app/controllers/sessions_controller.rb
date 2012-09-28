class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash[:error] = "Email or password is invalid."
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
  
  def reset_password
    
  end

  def send_new_password
    # create new password
    new_pass = (0...8).map{ ('a'..'z').to_a[rand(26)] }.join
    if validate_email(params[:email])
      @user = User.find_by_email(params[:email])
      if @user
        # update users password
        @user.update_attributes(:password => new_pass)
        # send email with new password
        ContactMailer.reset_password(params[:email], new_pass).deliver
        flash[:notice] = "Your password has been reset. Please check your email account."      
        redirect_to login_path
      else
        flash.now[:error] = "That email address is not on our system"     
        render 'reset_password'
      end
    else
      flash.now[:error] = @error     
      render 'reset_password'
    end
  end


private

def validate_email(email)
  @email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    if email.blank? 
      @error = "Please enter an email address."
      return false
    elsif email[@email_regex].nil?
      @error = "Email address not valid"
      return false
    else
      return true
    end
end

end
