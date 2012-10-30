class MonthlySale < ActiveRecord::Base
  attr_accessible :box_id, :subscription_id

  has_many :boxes
  has_many :subscriptions
end
