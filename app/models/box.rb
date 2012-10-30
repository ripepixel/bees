class Box < ActiveRecord::Base
  attr_accessible :box_number, :name, :box_contents_attributes
  

  has_many :box_contents
  accepts_nested_attributes_for :box_contents, allow_destroy: true

  has_many :stock_items, :through => :box_contents
  belongs_to :monthly_sale
end
