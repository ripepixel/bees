class CreateDeliveryCharges < ActiveRecord::Migration
  def change
    create_table :delivery_charges do |t|
      t.string :name
      t.decimal :weight_from
      t.decimal :weight_to
      t.decimal :price

      t.timestamps
    end
  end
end
