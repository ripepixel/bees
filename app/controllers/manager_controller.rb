class ManagerController < ApplicationController
  before_filter :authenticate_admin_user!
  before_filter :get_order_statuses

  def index
  	@subscriptions = Subscription.where("status = ?", "Active").order("created_at DESC")
    @cancelled = Subscription.where("status = ?", "Cancelled").order("created_at DESC")
    @comments = Comment.where("status = ?", "pending").count
    @m_end = MonthlySale.find(:all, :conditions => ["created_at between ? and ?",
             Date.today.beginning_of_month, Date.today.end_of_month])
    @orders = ShopOrder.all
  end

  def subscription_details
  	@subscription = Subscription.find(params[:id])
  end

  def pack_sheets
  	@subscriptions = Subscription.where("status = ?", "Active").order("created_at DESC")
  	render :layout => nil
  end

  def orders
    @orders = ShopOrder.all
    
  end

  def sort_orders
    @orders = ShopOrder.status_sort(params[:status])
  end

  def order_details
    @order = ShopOrder.find(params[:id])
  end

  def update_order_status
    @order = ShopOrder.find(params[:order_id])
    @order.update_attributes(:order_status_id => params[:order_status])

    # send email to customer to tell them order status has been updated

    redirect_to manager_order_details_path(:id => params[:order_id]), notice: "Order status has been updated"
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
      sale = MonthlySale.new(subscription_id: sub.id, box_id: next_box.id)
      count = count + 1
      end
    end
    redirect_to manager_month_end_path, notice: "Job has been processed #{count} times"
  end

  def get_order_statuses
    @statuses = OrderStatus.all
  end

end
