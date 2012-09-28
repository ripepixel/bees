class GocardlessController < ApplicationController

	def confirm_subscription
		begin
      GoCardless.confirm_resource params
      #Rails.logger.info("GOCARDLESS: #{params.inspect}")
      sub = Subscription.find(params[:state])
      sub.update_attributes(:status => "Active", :resource_id => params[:resource_id])
      redirect_to root_url, notice: "Yay, your subscription has been created."
    rescue GoCardless::ApiError => e
      @error = e
      render :text => "Could not confirm new subscription. Details: #{e}"
    end
	end
	
	def confirm_cancel_subscription
		sub = Subscription.find(params[:subscription_id])
		subscription = GoCardless.client.subscription(sub.resource_id)
		if subscription.status == "cancelled"
			sub.update_attributes(:status => "Cancelled")
			redirect_to account_url, notice: "Your subscription has been cancelled :("
		else
			redirect_to account_url, alert: "There was an error cancelling your subscription. Please log into your GoCardless account and cancel it from there."
		end
	end
	
	def confirm_gift
		begin
      GoCardless.confirm_resource params
      #Rails.logger.info("GOCARDLESS: #{params.inspect}")
      gift = Gift.find(params[:state])
      gift.update_attributes(:status => "Paid", :resource_id => params[:resource_id], :delivery_status => "Pending")
      redirect_to root_url, notice: "Thanks for your purchase."
    rescue GoCardless::ApiError => e
      @error = e
      render :text => "Could not confirm new subscription. Details: #{e}"
    end
	end

end

# https://sandbox.gocardless.com/merchants/04HCV5786Q/confirm_resource