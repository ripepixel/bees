class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.string :street
      t.string :town
      t.string :county
      t.string :postcode
      t.string :status
      t.date :first_delivery
      t.string :resource_id

      t.timestamps
    end
  end
end
