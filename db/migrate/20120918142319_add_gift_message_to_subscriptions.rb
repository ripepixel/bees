class AddGiftMessageToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :gift_message, :text
  end
end
