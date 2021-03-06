# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121105115927) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "article_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.integer  "article_category_id"
    t.string   "permalink"
    t.string   "image"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "blog_images", :force => true do |t|
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "box_contents", :force => true do |t|
    t.integer  "box_id"
    t.integer  "stock_item_id"
    t.integer  "quantity"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "boxes", :force => true do |t|
    t.string   "name"
    t.integer  "box_number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "article_id"
    t.string   "guest_email"
    t.string   "guest_username"
    t.text     "comment"
    t.string   "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "comments", ["article_id"], :name => "index_comments_on_article_id"

  create_table "delivery_charges", :force => true do |t|
    t.string   "name"
    t.decimal  "weight_from"
    t.decimal  "weight_to"
    t.decimal  "price"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "monthly_sales", :force => true do |t|
    t.integer  "subscription_id"
    t.integer  "box_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "order_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "details"
    t.string   "image"
    t.boolean  "is_subscription"
    t.integer  "sub_frequency"
    t.string   "sub_period"
    t.boolean  "has_sibling"
    t.decimal  "sub_price",       :precision => 8, :scale => 2
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "promo_codes", :force => true do |t|
    t.string   "code"
    t.string   "details"
    t.decimal  "discount",    :precision => 8, :scale => 2
    t.string   "promo_type"
    t.integer  "product_id"
    t.date     "expiry_date"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "one_time"
  end

  create_table "promo_uses", :force => true do |t|
    t.integer  "promo_code_id"
    t.integer  "user_id"
    t.integer  "subscription_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "shop_cart_items", :force => true do |t|
    t.integer  "shop_cart_id"
    t.integer  "shop_product_id"
    t.integer  "quantity"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "shop_carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shop_order_deliveries", :force => true do |t|
    t.integer  "shop_order_id"
    t.integer  "delivery_charge_id"
    t.decimal  "total_weight",       :precision => 8, :scale => 2
    t.decimal  "price",              :precision => 8, :scale => 2
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  create_table "shop_order_items", :force => true do |t|
    t.integer  "shop_order_id"
    t.integer  "shop_product_id"
    t.integer  "quantity"
    t.decimal  "price",           :precision => 8, :scale => 2
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "shop_orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "address"
    t.string   "telephone"
    t.integer  "order_status_id"
    t.string   "resource_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.decimal  "order_total"
  end

  create_table "shop_product_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "details"
  end

  create_table "shop_product_images", :force => true do |t|
    t.integer  "shop_product_id"
    t.string   "image"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "shop_products", :force => true do |t|
    t.string   "name"
    t.text     "details"
    t.decimal  "cost",                     :precision => 8, :scale => 2
    t.decimal  "sell",                     :precision => 8, :scale => 2
    t.decimal  "weight",                   :precision => 8, :scale => 2
    t.integer  "shop_product_category_id"
    t.boolean  "is_active"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  create_table "stock_items", :force => true do |t|
    t.integer  "supplier_id"
    t.string   "name"
    t.decimal  "cost",        :precision => 8, :scale => 2
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "subscription_items", :force => true do |t|
    t.integer  "subscription_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "price",           :precision => 8, :scale => 2
    t.string   "recipient1"
    t.integer  "age1"
    t.string   "gender1"
    t.string   "recipient2"
    t.integer  "age2"
    t.string   "gender2"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.string   "street"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.string   "status"
    t.date     "first_delivery"
    t.string   "resource_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "gift_message"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "telephone"
    t.string   "email"
    t.string   "website"
    t.string   "account_number"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
