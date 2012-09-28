class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :article_id
      t.string :guest_email
      t.string :guest_username
      t.text :comment
      t.string :status

      t.timestamps
    end
    add_index :comments, :article_id
  end
end
