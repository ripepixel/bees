class StockItem < ActiveRecord::Base
  attr_accessible :cost, :name, :supplier_id

  belongs_to :supplier
  has_many :box_content
end
