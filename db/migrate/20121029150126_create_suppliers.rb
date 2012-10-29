class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.text :address
      t.string :telephone
      t.string :email
      t.string :website
      t.string :account_number

      t.timestamps
    end
  end
end
