class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :details
      t.string :image
      t.boolean :is_subscription
      t.integer :sub_frequency
      t.string :sub_period
      t.boolean :has_sibling
      t.decimal :sub_price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
