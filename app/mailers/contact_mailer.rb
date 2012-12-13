class ContactMailer < ActionMailer::Base
  default from: "contact@littlebusybees.co.uk", to: "contact@littlebusybees.co.uk"
  
  def contact (sender, subject, message, name, sent_at = Time.now)
      @sender = sender
      @message = message
      @name = name
      @sent_at = sent_at.strftime("%B %e, %Y at %H:%M")
      mail(:from => @sender, :subject => subject)
    end
  
  def reset_password(to, new_pass)
  	@subject = "Password Reset on Little Busy Bees"
  	@new_pass = new_pass
  	mail(:to => to, :subject => @subject)
  end

  def change_password(to, pass)
    @pass = pass
  	@subject = "Password Changed on Little Busy Bees"
  	mail(:to => to, :subject => @subject)
  end
  
  def subscription_success(to, sub)
    @sub = sub
    @promo = PromoUse.find_by_subscription_id(@sub.id)
    @subject = "Thanks for your order from Little Busy Bees"
    mail(:to => to, :subject => @subject)
  end

  def new_subscription_admin(sub)
    to = "contact@littlebusybees.co.uk"
    @sub = sub
    @promo = PromoUse.find_by_subscription_id(@sub.id)
    @subject = "New Subscription on Little Busy Bees"
    mail(:to => to, :subject => @subject)
  end

  def new_shop_order_cust(to, ord)
    @ord = ord
    @items = ShopOrderItem.where("shop_order_id = ?", @ord.id)
    @subject = "Your Little Busy Bees Order"
    mail(:to => to, :subject => @subject)
  end

  def new_shop_order_admin(ord)
    @ord = ord
    @items = ShopOrderItem.where("shop_order_id = ?", @ord.id)
    @subject = "A shop order has been placed"
    mail(:subject => @subject)
  end

end
