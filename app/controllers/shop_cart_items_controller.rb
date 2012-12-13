class ShopCartItemsController < ApplicationController
  def create
  	@shop_cart = current_shop_cart
  	shop_product = ShopProduct.find(params[:shop_product_id])
  	item = add_shop_product(shop_product.id)

  	if item.save
  		redirect_to shop_basket_path, notice: "Item has been added to your basket"
  	else
  		redirect_to shop_basket_path, notice: "There was an error adding the item."
  	end
  end
  
  
  def destroy
    @item = ShopCartItem.where(id: params[:id], shop_cart_id: session[:shop_cart_id]).first
    @item.destroy
    redirect_to shop_basket_path, notice: "The item has been removed from your basket."
  end

  def update_items
    params["items"].each do |item|
      @cart_item = ShopCartItem.find(item["id"].to_i)
      if item["quantity"].to_i == 0
        @cart_item.destroy
      else
        @cart_item.update_attributes(:quantity => item["quantity"])
      end
    end
    redirect_to shop_basket_path, notice: "Your basket has been updated"
  end

  private
  
  def add_shop_product(shop_product_id)
    item = ShopCartItem.where("shop_product_id = ? AND shop_cart_id = ?", shop_product_id, session[:shop_cart_id]).first
    if item
      qty = item.quantity + 1
      item.update_attributes(quantity: qty)
    else
      item = ShopCartItem.create(:shop_cart_id => session[:shop_cart_id], :shop_product_id => shop_product_id, :quantity => 1)
    end
    item
  end
end
