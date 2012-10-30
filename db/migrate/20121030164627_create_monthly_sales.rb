class CreateMonthlySales < ActiveRecord::Migration
  def change
    create_table :monthly_sales do |t|
      t.integer :subscription_id
      t.integer :box_id

      t.timestamps
    end
  end
end
