class CreateSubscriptionItems < ActiveRecord::Migration
  def change
    create_table :subscription_items do |t|
      t.integer :subscription_id
      t.integer :product_id
      t.integer :quantity
      t.decimal :price, :precision => 8, :scale => 2
      t.string :recipient1
      t.integer :age1
      t.string :gender1
      t.string :recipient2
      t.integer :age2
      t.string :gender2

      t.timestamps
    end
  end
end
