class ManagerController < ApplicationController
  before_filter :authenticate_admin_user!

  def index
  	@subscriptions = Subscription.where("status = ?", "Active").order("created_at DESC")
    @cancelled = Subscription.where("status = ?", "Cancelled").order("created_at DESC")
    @comments = Comment.where("status = ?", "pending").count
  end

  def subscription_details
  	@subscription = Subscription.find(params[:id])
  end

  def pack_sheets
  	@subscriptions = Subscription.where("status = ?", "Active").order("created_at DESC")
  	render :layout => nil
  end

  def month_end
    @subs = Subscription.where("status = ?", "Active")
  end

  def process_month_end
    # Get status for each subscription, from GoCardless, and update
    subs = Subscription.where("status = ?", "Active")
    count = 0
    subs.each do |sub|
      subscription = GoCardless.client.subscription(sub.resource_id)
      if subscription.status == "cancelled"
        sub.update_attributes(:status => "Cancelled")
      else
      # Create sales records for the month
      box_no = ((Date.today.year*12+Date.today.month) - (sub.first_delivery.year*12+sub.first_delivery.month) + 1)
      next_box = Box.find_by_box_number(box_no)
      #sale = MonthlySale.new(subscription_id: sub.id, box_id: next_box.id)
      count = count + 1
      end
    end
    redirect_to manager_month_end_path, notice: "Job has been processed #{count} times"
  end

end
