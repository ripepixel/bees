class PagesController < ApplicationController
  def index
  end
  
  def craft_boxes
  	@page_title = "What's in our kids craft boxes"
  end
  
  def about_us
  	@page_title = "What do we do"
  end
  
  def faq
  	@page_title = "Frequently Asked Questions"
  end
  
  def terms
  	@page_title = "Terms and Conditions"
  end
  
  def privacy
    @page_title = "Privacy Policy"
  end

  def contact
    @page_title = "Contact Little Busy Bees"
    @name = ''
    @email = ''
    @message = ''
  end
  
  def send_contact_form
    @name = params[:name]
    @sender = params[:email]
    @subject = "Email from contact form"
    @message = params[:message]
    if validate(@sender, @subject, @message)
      ContactMailer.contact(@sender, @subject, @message, @name).deliver      
      flash[:success] = "Your message has been sent. We will reply as soon as possible."      
      redirect_to contact_path
    else
      flash.now[:error] = @error     
      render 'contact'
    end
  end
  
  def newsletter
    @page_title = "Sign up to our newsletter"
  end

  def newsletter_signup
    Gibbon.new(MAIL_CHIMP_API_KEY).list_subscribe(:id => '4b102b80dc', :email_address => params[:email])
    flash[:success] = "Hey, thanks for signing up to our newsletter."
    redirect_to root_url
  end
  
  
  private
      def validate(sender, subject, message)
        @email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        if sender.blank? || subject.blank? || message.blank?
          @error = "Message not sent: Please enter all information."
          return false
        elsif sender[@email_regex].nil?
          @error = "Message not sent: Email not valid"
          return false
        else
          return true
        end
      end
  
end
