class Box < ActiveRecord::Base
  attr_accessible :box_number, :name

  has_many :box_contents
  has_many :stock_items, :through => :box_contents
end
