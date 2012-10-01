class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :meta_defaults
  
  def authorise
    redirect_to login_url, alert: "Not authorised" if current_user.nil?
  end
  
  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def meta_defaults
    	@meta_keys = "crafts, arts crafts, kids crafts, childrens crafts, crafts for kids, crafts for children, craft activities"
    	@meta_desc = "Kids craft items delivered monthly. All arts and craft materials are included to keep the children entertained for hours. Receive a packed craft box every month, with free delivery."
    end
    
end
