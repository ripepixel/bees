class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.boolean :published
      t.integer :article_category_id
      t.string :permalink
      t.string :image

      t.timestamps
    end
  end
end
