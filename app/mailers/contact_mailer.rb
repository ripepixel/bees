class ContactMailer < ActionMailer::Base
  default from: "contact@littlebusybees.co.uk", to: "contact@littlebusybees.co.uk"
  
  def contact (sender, subject, message, name, sent_at = Time.now)
      @sender = sender
      @message = message
      @name = name
      @sent_at = sent_at.strftime("%B %e, %Y at %H:%M")
      mail(:subject => subject)
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

end
