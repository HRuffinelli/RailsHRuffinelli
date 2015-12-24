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

ActiveRecord::Schema.define(version: 20151214193248) do

  create_table "alerts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "rule_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "alerts", ["rule_id"], name: "index_alerts_on_rule_id", using: :btree
  add_index "alerts", ["user_id"], name: "index_alerts_on_user_id", using: :btree

  create_table "infos", force: :cascade do |t|
    t.integer  "server_id",  limit: 4
    t.float    "cpucharge",  limit: 24
    t.float    "diskspace",  limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "infos", ["server_id"], name: "index_infos_on_server_id", using: :btree

  create_table "rules", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.float    "cpuchargeexceed", limit: 24
    t.float    "diskspaceexceed", limit: 24
    t.integer  "timeexceed",      limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "priority",        limit: 4
  end

  create_table "servers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "ip",         limit: 255
    t.string   "dns",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "lastname",   limit: 65535
    t.text     "alias",      limit: 65535
    t.text     "email",      limit: 65535
    t.text     "password",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "infos", "servers"
end
