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

ActiveRecord::Schema.define(:version => 20110809133150) do

  create_table "advertisements", :force => true do |t|
    t.string   "image_url"
    t.string   "link_url"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_types_products", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "book_type_id"
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename",       :limit => 80
    t.string   "thumbnail",      :limit => 20
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "type",           :limit => 40
    t.integer  "user_id"
    t.integer  "assetable_id"
    t.string   "assetable_type", :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_id", "assetable_type", "type"], :name => "ndx_type_assetable"
  add_index "ckeditor_assets", ["assetable_id", "assetable_type"], :name => "fk_assets"
  add_index "ckeditor_assets", ["parent_id", "type"], :name => "ndx_type_name"
  add_index "ckeditor_assets", ["thumbnail", "parent_id"], :name => "assets_thumbnail_parent_id"
  add_index "ckeditor_assets", ["user_id", "assetable_type", "assetable_id"], :name => "assets_user_type_assetable_id"
  add_index "ckeditor_assets", ["user_id"], :name => "fk_user"

  create_table "comments", :force => true do |t|
    t.integer  "product_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   :default => 1
    t.integer  "order_id"
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "abstraction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
    t.string   "state",      :default => "pending"
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
    t.integer  "rating_sum",   :default => 0
    t.integer  "rating_times", :default => 0
    t.integer  "sales",        :default => 0
  end

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
    t.string   "email"
    t.string   "telephone"
    t.string   "description"
    t.string   "state",       :default => "open"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.integer  "shop_id"
  end

end
