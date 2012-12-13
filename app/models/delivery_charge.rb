class DeliveryCharge < ActiveRecord::Base
  attr_accessible :name, :price, :weight_from, :weight_to
end
