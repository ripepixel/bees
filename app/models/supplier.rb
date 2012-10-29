class Supplier < ActiveRecord::Base
  attr_accessible :account_number, :address, :email, :name, :telephone, :website

  has_many :stock_items
end
