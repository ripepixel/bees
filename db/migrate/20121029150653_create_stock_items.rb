class CreateStockItems < ActiveRecord::Migration
  def change
    create_table :stock_items do |t|
      t.integer :supplier_id
      t.string :name
      t.decimal :cost, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
