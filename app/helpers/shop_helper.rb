module ShopHelper
  
  def has_items?
    items = ShopCartItem.where("shop_cart_id = ?", session[:shop_cart_id])
  end
  
end
