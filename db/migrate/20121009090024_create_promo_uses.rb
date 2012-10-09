class CreatePromoUses < ActiveRecord::Migration
  def change
    create_table :promo_uses do |t|
      t.integer :promo_code_id
      t.integer :user_id
      t.integer :subscription_id

      t.timestamps
    end
  end
end
