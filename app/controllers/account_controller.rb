class AccountController < ApplicationController
  before_filter :authorise

  def index
    @subscriptions = Subscription.where("user_id = ? AND status = ?", current_user, "Active").order("created_at DESC")
    @cancelled = Subscription.where("user_id = ? AND status = ?", current_user, "Cancelled").order("created_at DESC")
    # @gifts = Gift.where("user_id = ? AND status = ?", current_user, "Paid").order("created_at DESC")
  end

  def subscription
   # @subscription = Subscription.where("id = ? AND user_id = ? AND status = ?", params[:subscription_id], current_user, "Active")
    begin
   		@subscription = Subscription.find(params[:subscription_id])
    rescue ActiveRecord::RecordNotFound
    	redirect_to account_url, alert: "Error finding Subscription details"
    else
	    if @subscription && @subscription.user_id == current_user.id
        # check for promo codes used
        @promo = PromoUse.find_by_subscription_id(@subscription.id)
	    	@gcsub = GoCardless.client.subscription(@subscription.resource_id)
	      render "subscription"
	    else
	      redirect_to account_url, alert: "Error finding Subscription details"
	    end
	  end
  end

  def change_password
    @page_title = "Change your password"
  end

  def send_change_password
    @old_pass = params[:old_pass]
    @new_pass = params[:new_pass]
    @user = User.find(session[:user_id])
    
    if @old_pass.empty? || @new_pass.empty?
      flash.now[:error] = "Please complete all fields"     
      render 'change_password' and return
    end
    if @new_pass.length < 6
      flash.now[:error] = "New password must be longer that 6 characters"     
      render 'change_password' and return
    elsif @user.authenticate(@old_pass)
      @user.update_attributes(:password => @new_pass)
      # send email
      ContactMailer.change_password(@user.email, @new_pass).deliver

      # log user out
      session[:user_id] = nil
      flash[:notice] = "Your password has been reset. Please log back in with your new password."      
      redirect_to login_path
    else
      flash.now[:error] = "Your old password is incorrect"     
      render 'change_password'
    end
      
  end



end
