ActiveAdmin.register BoxContent do
  menu :parent => "Boxes"

  index do
  	column :box
  	column :stock_item
  	column :quantity
  	default_actions
  end
end
