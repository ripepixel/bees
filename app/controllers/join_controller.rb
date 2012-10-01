class JoinController < ApplicationController
  def index
    @products = Product.where("is_subscription = ?", true).order("sub_price ASC")
    @meta_desc = "Kids craft items delivered monthly. All arts and craft materials are included to keep the children entertained for hours. Receive a packed craft box every month with at least 3 projects included, with free delivery."
    @meta_keys = "crafts, arts crafts, kids crafts, childrens crafts, crafts for kids, crafts for children, craft activities, craft projetcs"
  end
end
