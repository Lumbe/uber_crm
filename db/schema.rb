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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160803151807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "comment"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree

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
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "department_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "member_id",       null: false
    t.string   "member_type",     null: false
    t.integer  "group_id"
    t.string   "group_type"
    t.string   "group_name"
    t.string   "membership_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_memberships", ["group_name"], name: "index_group_memberships_on_group_name", using: :btree
  add_index "group_memberships", ["group_type", "group_id"], name: "index_group_memberships_on_group_type_and_group_id", using: :btree
  add_index "group_memberships", ["member_type", "member_id"], name: "index_group_memberships_on_member_type_and_member_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string "type"
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

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
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
    t.integer  "role",                   default: 0
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
