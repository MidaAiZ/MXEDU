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

ActiveRecord::Schema.define(version: 20170909090443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "index_appoints", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "content"
    t.string "time"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.index ["product_id"], name: "index_index_appoints_on_product_id"
    t.index ["user_id"], name: "index_index_appoints_on_user_id"
  end

  create_table "index_histories", force: :cascade do |t|
    t.string "product_name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "p_id"
    t.integer "times", default: 0
    t.string "remote_ip"
    t.index ["p_id"], name: "index_index_histories_on_p_id"
    t.index ["remote_ip"], name: "index_histories_on_remote_ip"
    t.index ["user_id"], name: "index_index_histories_on_user_id"
  end

  create_table "index_meterials", force: :cascade do |t|
    t.string "name"
    t.string "cate"
    t.string "tag"
    t.string "attach"
    t.bigint "school_id"
    t.bigint "admin_id"
    t.jsonb "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_index_meterials_on_admin_id"
    t.index ["admin_id"], name: "index_meterials_on_admin_id"
    t.index ["cate", "tag"], name: "index_meterials_on_cate_tag"
    t.index ["name"], name: "index_meterials_on_name"
    t.index ["school_id"], name: "index_index_meterials_on_school_id"
    t.index ["school_id"], name: "index_meterials_on_scholl_id"
  end

  create_table "index_orders", force: :cascade do |t|
    t.float "price"
    t.string "product_name"
    t.bigint "user_id"
    t.string "products_type"
    t.bigint "products_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["products_type", "products_id"], name: "index_index_orders_on_products_type_and_products_id"
    t.index ["user_id"], name: "index_index_orders_on_user_id"
  end

  create_table "index_products", force: :cascade do |t|
    t.string "name"
    t.string "intro"
    t.string "cate"
    t.jsonb "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price", default: 0.0
    t.string "details"
    t.string "cover"
    t.bigint "admin_id"
    t.integer "readtimes", default: 0
    t.boolean "is_deleted", default: false
    t.float "dis_price"
    t.index ["admin_id"], name: "index_index_products_on_admin_id"
    t.index ["info"], name: "index_index_products_on_info", using: :gin
    t.index ["name", "cate"], name: "index_index_products_on_name_and_cate"
  end

  create_table "index_users", force: :cascade do |t|
    t.string "number"
    t.string "password_digest"
    t.string "phone"
    t.string "email"
    t.string "name"
    t.string "sex"
    t.jsonb "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["info"], name: "index_users_on_info", using: :gin
  end

  create_table "manage_admins", force: :cascade do |t|
    t.string "number"
    t.string "password_digest"
    t.string "name"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
  end

  create_table "manage_carousels", force: :cascade do |t|
    t.string "image"
    t.string "link"
    t.boolean "show", default: true
    t.integer "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manage_fileworkers", force: :cascade do |t|
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manage_images", force: :cascade do |t|
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manage_schools", force: :cascade do |t|
    t.string "city"
    t.string "name"
    t.string "cate"
    t.string "sign"
    t.jsonb "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
