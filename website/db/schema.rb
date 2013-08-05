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

ActiveRecord::Schema.define(version: 20130804135100) do

  create_table "user", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "nickname"
    t.string   "email"
    t.string   "avatar"
    t.time     "birthday"
    t.integer  "knownWords"
    t.time     "createTime"
    t.time     "lastLoginTime"
    t.time     "loginTime"
    t.string   "weiboId"
    t.string   "weiboName"
    t.string   "weiboToken"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user", ["username"], name: "index_user_on_username", unique: true, using: :btree
  add_index "user", ["weiboId"], name: "index_user_on_weiboId", unique: true, using: :btree

  create_table "userword", force: true do |t|
    t.string   "word"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "userword", ["user_id", "word"], name: "index_userword_on_user_id_and_word", unique: true, using: :btree

  create_table "word", force: true do |t|
    t.string   "text"
    t.string   "chText"
    t.string   "soundmark"
    t.string   "soundUrl"
    t.string   "lang"
    t.integer  "classId"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "word", ["text", "classId"], name: "index_words_on_text_and_classId", unique: true, using: :btree

end
