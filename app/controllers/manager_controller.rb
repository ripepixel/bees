class ManagerController < ApplicationController
  before_filter :authenticate_admin_user!

  def index
  	@subscriptions = Subscription.where("status = ?", "Active").order("created_at DESC")
    @cancelled = Subscription.where("status = ?", "Cancelled").order("created_at DESC")
  end

  def subscription_details
  	@subscription = Subscription.find(params[:id])
  end

  def pack_sheets
  	@subscriptions = Subscription.where("status = ?", "Active").order("created_at DESC")
  	render :layout => nil
  end
end
