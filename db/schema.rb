# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_01_093325) do

  create_table "hashtags", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["text"], name: "index_hashtags_on_text", unique: true
  end

  create_table "hashtags_questions", id: false, force: :cascade do |t|
    t.integer "question_id", null: false
    t.integer "hashtag_id", null: false
    t.index ["hashtag_id", "question_id"], name: "index_hashtags_questions_on_hashtag_id_and_question_id"
    t.index ["question_id", "hashtag_id"], name: "index_hashtags_questions_on_question_id_and_hashtag_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "answer"
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "author_id"
    t.index ["author_id"], name: "index_questions_on_author_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "avatar_url"
    t.string "password_hash"
    t.string "password_salt"
    t.string "profilecolor", default: "#4f8bc0"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "questions", "users"
end
