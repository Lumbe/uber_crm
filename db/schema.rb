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

ActiveRecord::Schema.define(version: 20170130155702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "trackable_department_id"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "attachments", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "message_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "data_fingerprint"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "body"
    t.integer  "comment_type",     default: 0
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  end

  create_table "commercial_proposals", force: :cascade do |t|
    t.string   "project_name"
    t.decimal  "house_kit_price",           precision: 8, scale: 2
    t.decimal  "additional_services_price", precision: 8, scale: 2
    t.integer  "contact_id"
    t.integer  "user_id"
    t.decimal  "discount",                  precision: 8, scale: 2
    t.decimal  "dollar_exchange_rate",      precision: 5, scale: 2
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "project_url"
    t.decimal  "house_installation_price",  precision: 8, scale: 2
    t.decimal  "house_square",              precision: 8, scale: 2
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
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "department_id"
    t.integer  "status",         default: 0
    t.datetime "proposal_sent"
    t.string   "alt_email"
    t.boolean  "do_not_call",    default: false
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
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "city",                default: ""
    t.string   "address",             default: ""
    t.string   "facebook",            default: ""
    t.string   "vkontakte",           default: ""
    t.string   "website",             default: ""
    t.string   "email",               default: ""
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
    t.integer  "customer_id"
    t.integer  "assigned_to"
    t.integer  "department_id"
    t.integer  "contact_id"
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

  create_table "messages", force: :cascade do |t|
    t.string   "from"
    t.string   "to"
    t.string   "subject"
    t.string   "body",                   default: ""
    t.string   "message_id"
    t.datetime "delivered_at"
    t.datetime "opened_at"
    t.integer  "user_id"
    t.integer  "commercial_proposal_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "inbound",                default: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "actor_id"
    t.datetime "read_at"
    t.string   "action"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "notification_type", default: 0
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
