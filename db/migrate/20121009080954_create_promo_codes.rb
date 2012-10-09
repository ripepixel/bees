class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :promo_codes do |t|
      t.string :code
      t.string :details
      t.decimal :discount, :precision => 8, :scale => 2
      t.string :promo_type
      t.integer :product_id
      t.date :expiry_date

      t.timestamps
    end
  end
end
