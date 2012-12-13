class ShopController < ApplicationController
  
  before_filter :get_shop_cats, :get_cart_items

  def index
    @page_title = "Craft Shop"
    @products = ShopProduct.where("is_active = ?", true).order("RANDOM()")
  end

  def category
  	@categ = ShopProductCategory.find_by_name(params[:name])
  	if @categ.nil?
  		redirect_to shop_path
  	else
  	  @page_title = @categ.name
  		@products = ShopProduct.where("shop_product_category_id = ? AND is_active = ?", @categ.id, true).order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
  	end
  end

  def product_details
	@item = ShopProduct.find(params[:id])
	@page_title = @item.name
	@others = ShopProduct.where("shop_product_category_id = ? AND id != ?", @item.shop_product_category_id, @item.id).order("RANDOM()").limit(4)
  end

  def basket
    @shop_cart = current_shop_cart
  end
  
  def checkout
    @shop_cart = current_shop_cart
  end
  
  def empty_basket
    cart = ShopCart.find(session[:shop_cart_id])
    cart.destroy
    redirect_to shop_path, notice: "Your basket has been emptied"
  end

  def get_shop_cats
	  @categories = ShopProductCategory.all
  end
  
  def get_cart_items
    @cart_items = ShopCartItem.where("shop_cart_id= ?", session[:shop_cart_id])
  end
  
  def create_order
    if params[:name].empty? || params[:address].empty?
      redirect_to shop_checkout_path, alert: "Please fill in all required fields"
    else
      @shop_cart = current_shop_cart
      
      # create user if not exists
      if !current_user
        # see if email exists if not logged in
        @user = User.find_by_email(params[:email])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
        else
          # create user account if does not exist, set account_id in session
          if params[:email].empty? || params[:password].empty?
            flash[:error] = "Please complete email and password fields"
            redirect_to shop_checkout_path and return
          else
            @user = User.new(:email => params[:email], :password => params[:password])
            if @user.save
              session[:user_id] = @user.id
            else
              flash[:error] = "There was an error creating your account"
              redirect_to shop_checkout_path and return
            end
          end
          
        end 
          
      end

      @cart_items = ShopCartItem.where(:shop_cart_id => @shop_cart.id)

      subtotal = @cart_items.first.shop_cart.total_cart_price
      weight = @cart_items.first.shop_cart.total_cart_weight
      if subtotal > 50
        delivery = 0.00
      else
        delivery = @cart_items.first.shop_cart.delivery_charge(weight)
      end
      order_total = subtotal + delivery

      @order = ShopOrder.create(:user_id => current_user.id, :name => params[:name], :address => params[:address], :telephone => params[:telephone], :order_status_id => 1, :order_total => order_total)
      @cart_items.each do |item|
        ShopOrderItem.create(:shop_order_id => @order.id, :shop_product_id => item.shop_product.id, :quantity => item.quantity, :price => item.shop_product.sell)
      end

      ShopOrderDelivery.create(:shop_order_id => @order.id, :total_weight => weight, :price => delivery)

      # delete cart and cart_items
      @shop_cart.destroy

      # set up payment fields
      url_params = {
          :redirect_uri => confirm_shop_order_url,
          :amount => order_total,
          :name => "Little Busy Bees Shop Order ref:#{@order.id}",
          :state => @order.id,
          :user => {
            :email => current_user.email
          }
        }


      # redirect to gocardless
      url = GoCardless.new_bill_url(url_params)
      redirect_to url
    end

  end


end


