class CreateBoxContents < ActiveRecord::Migration
  def change
    create_table :box_contents do |t|
      t.integer :box_id
      t.integer :stock_item_id
      t.integer :quantity

      t.timestamps
    end
  end
end
