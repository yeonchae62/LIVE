# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_21_022907) do
  create_table "games", force: :cascade do |t|
    t.string "game_title", null: false
    t.string "url"
    t.string "source"
    t.string "researcher"
    t.string "included"
    t.string "exclusion_notes"
    t.string "publication_year"
    t.string "developers"
    t.string "publisher"
    t.string "used_in_class"
    t.string "downloadable"
    t.string "discontinued"
    t.string "generalized_subject"
    t.string "subject1"
    t.string "subject2"
    t.string "remainder"
    t.string "teaching"
    t.string "college_users"
    t.string "cost"
    t.string "game_type"
    t.string "genre"
    t.string "tags"
    t.string "game_time"
    t.string "dimensions"
    t.string "sound"
    t.string "platform"
    t.string "spanish"
    t.string "other_languages"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.float "cost_value"
  end

  create_table "saved_games", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_saved_games_on_game_id"
    t.index ["user_id"], name: "index_saved_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "saved_games", "games"
  add_foreign_key "saved_games", "users"
end
