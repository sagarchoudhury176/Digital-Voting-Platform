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

ActiveRecord::Schema.define(version: 2019_05_14_075354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.string "affilation", default: ""
    t.text "past_experiences", default: ""
    t.text "about_me", default: ""
    t.text "link", default: ""
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_candidates_on_user_id"
  end

  create_table "elections", force: :cascade do |t|
    t.string "position"
    t.datetime "deadline"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "session"
    t.json "vote_count"
    t.bigint "candidate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_elections_on_candidate_id"
  end

  create_table "nominations", force: :cascade do |t|
    t.bigint "candidate_id"
    t.bigint "election_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_nominations_on_candidate_id"
    t.index ["election_id"], name: "index_nominations_on_election_id"
  end

  create_table "user_details", force: :cascade do |t|
    t.string "gender"
    t.string "branch"
    t.integer "year"
    t.string "roll_number"
    t.string "course"
    t.string "section"
    t.boolean "opt_in"
    t.string "residence"
    t.decimal "cgpa"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", default: "", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.text "data"
    t.bigint "election_id"
    t.bigint "candidate_id"
    t.bigint "user_id"
    t.bigint "vote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_votes_on_candidate_id"
    t.index ["election_id"], name: "index_votes_on_election_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["vote_id"], name: "index_votes_on_vote_id"
  end

  add_foreign_key "candidates", "users"
  add_foreign_key "elections", "candidates"
  add_foreign_key "nominations", "candidates"
  add_foreign_key "nominations", "elections"
  add_foreign_key "user_details", "users"
  add_foreign_key "votes", "candidates"
  add_foreign_key "votes", "elections"
  add_foreign_key "votes", "users"
  add_foreign_key "votes", "votes"
end
