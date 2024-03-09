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

ActiveRecord::Schema[7.1].define(version: 2024_02_13_035850) do
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
  end

end
