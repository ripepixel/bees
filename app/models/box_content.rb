class BoxContent < ActiveRecord::Base
  attr_accessible :box_id, :quantity, :stock_item_id

  belongs_to :box
  belongs_to :stock_item
end
