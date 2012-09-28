class JoinController < ApplicationController
  def index
    @products = Product.where("is_subscription = ?", true).order("sub_price ASC")
  end
end
