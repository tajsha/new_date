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

ActiveRecord::Schema.define(version: 20141101224339) do

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "favorites", force: true do |t|
    t.integer  "sender_id"
    t.string   "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "finished_mails", force: true do |t|
    t.integer  "mail_campaign_id"
    t.string   "from"
    t.string   "to"
    t.string   "subject"
    t.text     "body_html"
    t.integer  "retries"
    t.datetime "last_retry_at"
    t.string   "last_error"
    t.datetime "sent_at"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body_text"
    t.boolean  "opened",           default: false, null: false
    t.string   "key"
  end

  add_index "finished_mails", ["key"], name: "index_finished_mails_on_key", unique: true, using: :btree
  add_index "finished_mails", ["mail_campaign_id", "status"], name: "index_finished_mails_on_mail_campain_id_and_status", using: :btree
  add_index "finished_mails", ["to", "mail_campaign_id"], name: "index_finished_mails_on_to_and_mail_campaign_id", using: :btree

  create_table "galleries", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "gallery_id"
  end

  create_table "letsgos", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.string   "tag"
    t.integer  "repost_from_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "letsgos", ["user_id", "created_at"], name: "index_letsgos_on_user_id_and_created_at", using: :btree

  create_table "locations", force: true do |t|
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_campaign_attachments", force: true do |t|
    t.integer  "mail_campaign_id",              null: false
    t.string   "filename",                      null: false
    t.string   "path",             limit: 2048
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mail_campaign_attachments", ["mail_campaign_id"], name: "index_mail_campaign_attachments_on_mail_campaign_id", using: :btree

  create_table "mail_campaigns", force: true do |t|
    t.integer  "mailing_list_id"
    t.string   "from"
    t.string   "subject"
    t.text     "body_html"
    t.integer  "unsubscribe_methods"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body_text"
    t.integer  "sent_mails_count",    default: 0, null: false
    t.integer  "opened_mails_count",  default: 0, null: false
  end

  add_index "mail_campaigns", ["mailing_list_id"], name: "index_mail_campaigns_on_mailing_list_id", using: :btree

  create_table "mail_keys", force: true do |t|
    t.string   "email"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mail_keys", ["email"], name: "index_mail_keys_on_email", unique: true, using: :btree
  add_index "mail_keys", ["key"], name: "index_mail_keys_on_key", unique: true, using: :btree

  create_table "mailing_lists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], name: "index_notifications_on_conversation_id", using: :btree

  create_table "payment_notifications", force: true do |t|
    t.text     "params"
    t.string   "status"
    t.string   "transaction_id"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "amount",     default: 1
    t.string   "token"
    t.string   "identifier"
    t.string   "payer_id"
    t.boolean  "recurring",  default: false
    t.boolean  "digital",    default: false
    t.boolean  "popup",      default: false
    t.boolean  "completed",  default: false
    t.boolean  "canceled",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "name"
    t.string   "gallery_id"
    t.integer  "user_id"
    t.integer  "avatar"
  end

  create_table "plans", force: true do |t|
    t.string   "name"
    t.decimal  "price",      precision: 15, scale: 10
    t.integer  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration"
  end

  create_table "questions", force: true do |t|
    t.string   "question"
    t.string   "answer"
    t.integer  "asked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "no_email"
    t.integer  "conversation_id"
  end

  create_table "queued_mails", force: true do |t|
    t.integer  "mail_campaign_id"
    t.string   "to"
    t.integer  "retries",          default: 0,     null: false
    t.datetime "last_retry_at"
    t.string   "last_error"
    t.boolean  "locked",           default: false, null: false
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
  end

  add_index "queued_mails", ["locked", "locked_at"], name: "index_queued_mails_on_locked_and_locked_at", using: :btree
  add_index "queued_mails", ["locked", "retries", "id"], name: "index_queued_mails_on_locked_retries_and_id", using: :btree
  add_index "queued_mails", ["mail_campaign_id", "to"], name: "index_queued_mails_on_mail_campain_id_and_to", unique: true, using: :btree
  add_index "queued_mails", ["retries", "locked"], name: "index_queued_mails_on_retries_and_locked", using: :btree

  create_table "receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "receipts", ["notification_id"], name: "index_receipts_on_notification_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer "follower_id"
    t.integer "followed_id"
  end

  create_table "searches", force: true do |t|
    t.string   "gender"
    t.string   "age"
    t.string   "zip_code"
    t.string   "children"
    t.string   "religion"
    t.string   "ethnicity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_age"
    t.integer  "max_age"
  end

  create_table "smailer_properties", force: true do |t|
    t.string   "name"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes"
  end

  add_index "smailer_properties", ["name"], name: "index_smailer_properties_on_name", unique: true, using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer  "plan_id"
    t.string   "email"
    t.string   "stripe_customer_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paypal_customer_token"
    t.string   "paypal_recurring_profile_token"
    t.integer  "user_id"
    t.integer  "cancelled"
    t.string   "cancellation_date"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "zip_code"
    t.date     "birthday"
    t.string   "name"
    t.string   "username"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "sexuality"
    t.string   "career"
    t.string   "education"
    t.string   "religion"
    t.string   "politics"
    t.string   "children"
    t.string   "height"
    t.string   "user_smoke"
    t.string   "user_drink"
    t.string   "about_me"
    t.string   "inches"
    t.string   "feet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "admin"
    t.string   "role"
    t.integer  "roles_mask"
    t.integer  "age"
    t.integer  "default_photo_id"
    t.string   "time_zone"
    t.integer  "avatar_id",              default: 8
    t.integer  "average_response_time"
    t.integer  "response_rate"
    t.integer  "response_total"
    t.integer  "plan_id"
    t.boolean  "no_email"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["zip_code"], name: "index_users_on_zip_code", using: :btree

  add_foreign_key "notifications", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", name: "receipts_on_notification_id"

end
