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

ActiveRecord::Schema.define(version: 20161019114147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "body"
    t.integer  "comment_type",     default: 0
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  end

  create_table "competitors", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "assigned_to"
    t.string   "phone"
    t.string   "email"
    t.string   "location"
    t.string   "project"
    t.string   "square"
    t.string   "floor"
    t.string   "question"
    t.string   "region"
    t.string   "source"
    t.boolean  "online_request"
    t.boolean  "come_in_office"
    t.boolean  "phone_call"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "department_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "customer_id"
    t.integer  "assigned_to"
    t.string   "phone"
    t.string   "email"
    t.string   "location"
    t.string   "project"
    t.string   "square"
    t.string   "floor"
    t.string   "question"
    t.string   "region"
    t.string   "source"
    t.boolean  "online_request"
    t.boolean  "come_in_office"
    t.boolean  "phone_call"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "department_id"
    t.integer  "status",         default: 0
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "assigned_to"
    t.string   "phone"
    t.string   "email"
    t.string   "location"
    t.string   "project"
    t.string   "square"
    t.string   "floor"
    t.string   "question"
    t.string   "region"
    t.string   "source"
    t.boolean  "online_request"
    t.boolean  "come_in_office"
    t.boolean  "phone_call"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "leads", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "location"
    t.string   "project"
    t.string   "square"
    t.string   "floor"
    t.text     "question"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "region"
    t.string   "source"
    t.boolean  "online_request", default: false
    t.boolean  "come_in_office", default: false
    t.boolean  "phone_call",     default: false
    t.integer  "status",         default: 0
    t.integer  "user_id"
    t.integer  "contact_id"
    t.integer  "customer_id"
    t.integer  "assigned_to"
    t.integer  "department_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "department_id"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "role",          default: 0
    t.index ["department_id"], name: "index_memberships_on_department_id", using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "actor_id"
    t.datetime "read_at"
    t.string   "action"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             default: "",    null: false
    t.string   "last_name",              default: "",    null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.string   "phone"
    t.string   "skype"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "current_department_id"
    t.string   "current_role",           default: ""
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "memberships", "departments"
  add_foreign_key "memberships", "users"
end
