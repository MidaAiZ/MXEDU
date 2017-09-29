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

ActiveRecord::Schema.define(version: 20170929155513) do

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

  create_table "index_images", force: :cascade do |t|
    t.string "link"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_images_on_user_id"
    t.index ["user_id"], name: "index_index_images_on_user_id"
  end

  create_table "index_mat_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.string "remote_ip"
    t.bigint "material_id"
    t.integer "times", default: 0
    t.string "material_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index__mat_histories_on_mat_id"
    t.index ["user_id"], name: "index__mat_histories_on_user_id"
  end

  create_table "index_materials", force: :cascade do |t|
    t.string "name"
    t.string "tag"
    t.string "attach"
    t.bigint "school_id"
    t.bigint "admin_id"
    t.jsonb "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover"
    t.boolean "is_deleted", default: false
    t.bigint "cate_id"
    t.integer "readtimes", default: 0
    t.string "grade"
    t.integer "dload_count", default: 0
    t.index ["admin_id"], name: "index_materials_on_admin_id"
    t.index ["cate_id"], name: "index_materials_on_cate_id"
    t.index ["grade"], name: "index_materials_on_grade"
    t.index ["name", "tag"], name: "index_materials_on_name_tag"
    t.index ["school_id"], name: "index_materials_on_school_id"
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

  create_table "index_post_comments", force: :cascade do |t|
    t.string "content"
    t.integer "thumbs_count"
    t.integer "comments_count"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.jsonb "images"
    t.index ["post_id"], name: "index_post_comments_on_post_id"
    t.index ["user_id"], name: "index_post_comments_on_user_id"
  end

  create_table "index_post_son_comments", force: :cascade do |t|
    t.string "content"
    t.integer "thumbs_count"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_cmt_id"
    t.index ["post_cmt_id"], name: "index_post_son_cmts_on_cmt_id"
    t.index ["user_id"], name: "index_post_son_comments_on_user_id"
  end

  create_table "index_posts", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.integer "readtimes"
    t.integer "comments_count"
    t.integer "thumbs_count"
    t.jsonb "info"
    t.bigint "user_id"
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 1
    t.bigint "cate_id"
    t.jsonb "images"
    t.index ["cate_id"], name: "index_posts_on_cate_id"
    t.index ["name"], name: "index_posts_on_name"
    t.index ["school_id"], name: "index_posts_on_manage_school_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "index_products", force: :cascade do |t|
    t.string "name"
    t.string "intro"
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
    t.bigint "school_id"
    t.bigint "cate_id"
    t.bigint "company_id"
    t.string "tag"
    t.index ["admin_id"], name: "index_index_products_on_admin_id"
    t.index ["cate_id"], name: "index_products_on_cate_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["info"], name: "index_index_products_on_info", using: :gin
    t.index ["name", "tag"], name: "index_products_on_name_tag"
    t.index ["school_id"], name: "index_products_on_school_id"
  end

  create_table "index_thumbs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remote_ip"
    t.index ["remote_ip"], name: "index_thumbs_on_remote_ip"
    t.index ["resource_id", "resource_type"], name: "index_thumbs_on_rsc_id_type"
    t.index ["user_id"], name: "index_thumbs_on_user_id"
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
    t.bigint "school_id"
    t.index ["info"], name: "index_users_on_info", using: :gin
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  create_table "manage_admins", force: :cascade do |t|
    t.string "number"
    t.string "password_digest"
    t.string "name"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "is_deleted", default: false
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

  create_table "manage_material_cates", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted", default: false
    t.integer "materials_count", default: 0
  end

  create_table "manage_material_files", force: :cascade do |t|
    t.string "file"
    t.bigint "material_id"
    t.string "name"
    t.string "size"
    t.string "f_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dload_count", default: 0
    t.index ["material_id"], name: "index_manage_material_files_on_material_id"
    t.index ["name"], name: "index_manage_material_files_on_name"
  end

  create_table "manage_post_cates", force: :cascade do |t|
    t.string "name"
    t.integer "posts_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manage_product_cates", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "products_count", default: 0
  end

  create_table "manage_product_companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cate"
    t.integer "products_count", default: 0
  end

  create_table "manage_schools", force: :cascade do |t|
    t.string "city"
    t.string "name"
    t.string "cate"
    t.string "sign"
    t.jsonb "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted", default: false
    t.integer "users_count", default: 0
    t.integer "products_count", default: 0
    t.integer "materials_count", default: 0
  end

end
