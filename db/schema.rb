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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_14_172948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brand_representatives", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "name", null: false
    t.string "email"
    t.integer "phonenumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_representatives_on_brand_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.string "kana_name", null: false
    t.text "description"
    t.string "image_name", default: "no_image.jpg"
    t.integer "rate_of_retail_price"
    t.string "website"
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "user_id"
    t.string "sku_id", null: false
    t.integer "quantity", null: false
    t.integer "total_item_price"
    t.integer "discount"
    t.integer "price_w_tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sku_id"], name: "index_cart_items_on_sku_id"
    t.index ["user_id"], name: "index_cart_items_on_user_id"
  end

  create_table "item_colors", id: :string, force: :cascade do |t|
    t.bigint "item_id"
    t.string "color_name", null: false
    t.string "color_code", null: false
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_colors_on_item_id"
  end

  create_table "item_images", force: :cascade do |t|
    t.bigint "item_id"
    t.string "item_color_id", null: false
    t.string "image_name", default: "no_image.jpg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_color_id"], name: "index_item_images_on_item_color_id"
    t.index ["item_id"], name: "index_item_images_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", default: "未定"
    t.bigint "brand_id"
    t.text "description_1"
    t.text "description_2"
    t.string "category", null: false
    t.integer "price", null: false
    t.integer "wholesale_price"
    t.integer "sele_price"
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_items_on_brand_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.string "item_color_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_color_id"], name: "index_likes_on_item_color_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "measuring_items", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "default", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "measuring_values", force: :cascade do |t|
    t.string "sku_id", null: false
    t.bigint "measuring_item_id"
    t.string "measuring_item_name", null: false
    t.float "value", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["measuring_item_id"], name: "index_measuring_values_on_measuring_item_id"
    t.index ["sku_id"], name: "index_measuring_values_on_sku_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "total_item_price", null: false
    t.integer "discount"
    t.integer "fee"
    t.integer "final_price", null: false
    t.string "method_of_payment", null: false
    t.string "user_name", null: false
    t.string "user_email", null: false
    t.integer "shipping_postal_code", null: false
    t.string "shipping_adress", null: false
    t.string "shipping_cond_n_room"
    t.integer "user_phonenumber", null: false
    t.string "shipping_date", default: "指定なし"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "order_id"
    t.string "sku_id", null: false
    t.integer "quantity"
    t.integer "total_item_price"
    t.integer "discount", default: 0
    t.integer "price_w_tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_sales_on_order_id"
    t.index ["sku_id"], name: "index_sales_on_sku_id"
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skus", id: :string, force: :cascade do |t|
    t.bigint "item_id"
    t.string "item_color_id", null: false
    t.string "size_name", null: false
    t.bigint "size_id"
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_color_id"], name: "index_skus_on_item_color_id"
    t.index ["item_id"], name: "index_skus_on_item_id"
    t.index ["size_id"], name: "index_skus_on_size_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "sku_id", null: false
    t.integer "all_quantity", default: 0
    t.integer "quantity_in_cart", default: 0
    t.integer "quantity_on_display", null: false
    t.integer "quantity_in_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sku_id"], name: "index_stocks_on_sku_id"
  end

  create_table "topic_items", force: :cascade do |t|
    t.bigint "topic_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_topic_items_on_item_id"
    t.index ["topic_id"], name: "index_topic_items_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name", default: "未定"
    t.string "type", null: false
    t.string "description"
    t.string "sum_image_name", default: "no_image.jpg"
    t.string "main_image_name", default: "no_image.jpg"
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "family_name", null: false
    t.string "first_name", null: false
    t.string "email", null: false
    t.integer "postal_code"
    t.string "adress"
    t.string "cond_n_room"
    t.integer "phonenumber", null: false
    t.string "password_digest", null: false
    t.boolean "mail_magazine", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "brand_representatives", "brands"
  add_foreign_key "cart_items", "skus"
  add_foreign_key "cart_items", "users"
  add_foreign_key "item_colors", "items"
  add_foreign_key "item_images", "item_colors"
  add_foreign_key "item_images", "items"
  add_foreign_key "items", "brands"
  add_foreign_key "likes", "item_colors"
  add_foreign_key "likes", "users"
  add_foreign_key "measuring_values", "measuring_items"
  add_foreign_key "measuring_values", "skus"
  add_foreign_key "orders", "users"
  add_foreign_key "sales", "orders"
  add_foreign_key "sales", "skus"
  add_foreign_key "sales", "users"
  add_foreign_key "skus", "item_colors"
  add_foreign_key "skus", "items"
  add_foreign_key "skus", "sizes"
  add_foreign_key "stocks", "skus"
  add_foreign_key "topic_items", "items"
  add_foreign_key "topic_items", "topics"
end
