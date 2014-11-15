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

ActiveRecord::Schema.define(version: 20141115052136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowed_methods", force: true do |t|
    t.integer  "challenge_id", null: false
    t.string   "method",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", force: true do |t|
    t.string   "name",              null: false
    t.string   "difficulty",        null: false
    t.string   "description",       null: false
    t.string   "problem_statement", null: false
    t.string   "method_skeleton",   null: false
    t.string   "answer",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "input_results", force: true do |t|
    t.integer  "challenge_id", null: false
    t.string   "input",        null: false
    t.string   "result",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solutions", force: true do |t|
    t.integer  "user_id",       null: false
    t.integer  "challenge_id",  null: false
    t.string   "method_string", null: false
    t.boolean  "success",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.boolean  "admin",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end
