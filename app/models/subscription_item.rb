class SubscriptionItem < ActiveRecord::Base
  attr_accessible :age1, :age2, :gender1, :gender2, :price, :product_id, :quantity, :recipient1, :recipient2, :subscription_id
  
  belongs_to :product
  belongs_to :subscription

  before_save :get_product_price_set_quantity

  validates_presence_of :recipient1, :age1, :gender1

  private

  	def get_product_price_set_quantity
  		self.price = self.product.sub_price
  		self.quantity = 1
  	end
end
