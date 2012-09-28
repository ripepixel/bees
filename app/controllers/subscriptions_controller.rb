class SubscriptionsController < ApplicationController

respond_to :html, :json

  def new
    @product = Product.find(params[:product_id])
    @subscription = Subscription.new
    @subscription.subscription_items.build
    
    if !current_user
		  # see if email exists if not logged in
      @user = User.find_by_email(params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
      else
        # create user account if does not exist, set account_id in session
        if params[:email].empty? || params[:password].empty?
          flash[:error] = "Please complete email and password fields"
          redirect_to join_path and return
        else
          @user = User.new(:email => params[:email], :password => params[:password])
          if @user.save
            session[:user_id] = @user.id
          else
            flash[:error] = "There was an error creating your account"
            redirect_to join_path and return
          end
        end
        
      end 
        
    end
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    start_date = get_start_date
  	@subscription.user_id = current_user.id
  	@subscription.first_delivery = start_date
  	# set the gift status to pending
  	@subscription.status = "Pending"
  	item = @subscription.subscription_items.first
    
    if @subscription.save
      url_params = {
        :redirect_uri => confirm_subscription_url,
  			:amount => item.price,
  			:interval_unit => item.product.sub_period,
  			:interval_length => item.product.sub_frequency,
  			:name => item.product.name,
  			:state => @subscription.id,
  			:start_at => start_date,
  			:user => {
  			  :email => current_user.email
  			}
  		}

  		url = GoCardless.new_subscription_url(url_params)
  		redirect_to url
    else
      flash[:error] = "Please make sure you have completed all form fields."
      redirect_to new_subscription_path(:product_id => item.product.id)
    end
  end

  def update
    @subscription = Subscription.find(params[:id])
    @subscription.update_attributes(params[:subscription])
    respond_with @subscription
  end
  
  def cancel_subscription
  	@subscription = Subscription.find_by_resource_id(params[:resource_id])
  	sub = GoCardless.client.subscription(@subscription.resource_id).cancel!
  	redirect_to confirm_cancel_subscription_path(:subscription_id => @subscription.id)
   end
  
  def get_start_date
    # Set first date to November for launch
    if Date.today < "2012-11-01"
    	start_date = "2012-11-14"
    else
    	if Date.today.day <= 13
	    	start_date = "#{Date.today.year}-#{Date.today.month}-14"
	  	else
	    	start_date = "#{Date.today.year}-#{Date.today.month + 1}-14"
	  	end
	  end
	end
end
