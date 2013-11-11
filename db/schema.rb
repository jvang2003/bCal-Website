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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131111090652) do

  create_table "calendars", :force => true do |t|
    t.string   "name"
    t.string   "fee_required"
    t.string   "key"
    t.string   "visib"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "disabled"
    t.string   "access_token"
    t.string   "refresh_token"
    t.string   "building"
    t.string   "type"
    t.string   "dept"
  end

  create_table "events", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "request_id"
    t.string   "google_cal_id"
  end

  create_table "requests", :force => true do |t|
    t.integer  "people"
    t.text     "reason"
    t.text     "details"
    t.string   "place"
    t.datetime "time"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.boolean  "approved"
    t.string   "status"
    t.string   "course_related"
    t.string   "accept_different_room"
    t.string   "department"
    t.integer  "calendar_id"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "password"
    t.string   "email"
  end

end
