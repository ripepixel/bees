ActiveAdmin.register Product do
	menu :parent => "Subscriptions"
	
  index do
    column :name
    column :is_subscription
    column :sub_frequency
    column :sub_period
    column :has_sibling
    column :sub_price
    default_actions
  end
end
