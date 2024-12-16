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

ActiveRecord::Schema[8.0].define(version: 2024_12_16_212958) do
  create_table "goals", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "due_date"
    t.integer "study_area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["due_date"], name: "index_goals_on_due_date"
    t.index ["study_area_id"], name: "index_goals_on_study_area_id"
    t.index ["title"], name: "index_goals_on_title"
  end

  create_table "resource_tags", force: :cascade do |t|
    t.integer "resource_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_resource_tags_on_resource_id"
    t.index ["tag_id"], name: "index_resource_tags_on_tag_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "resource_type", null: false
    t.string "url"
    t.integer "goal_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_resources_on_goal_id"
    t.index ["user_id"], name: "index_resources_on_user_id"
  end

  create_table "study_areas", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_study_areas_on_title"
    t.index ["user_id"], name: "index_study_areas_on_user_id"
  end

  create_table "study_sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "goal_id", null: false
    t.integer "duration_minutes", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_study_sessions_on_goal_id"
    t.index ["user_id", "created_at"], name: "index_study_sessions_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_study_sessions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id"], name: "index_tags_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "goals", "study_areas"
  add_foreign_key "resource_tags", "resources"
  add_foreign_key "resource_tags", "tags"
  add_foreign_key "resources", "goals"
  add_foreign_key "resources", "users"
  add_foreign_key "study_areas", "users"
  add_foreign_key "study_sessions", "goals"
  add_foreign_key "study_sessions", "users"
  add_foreign_key "tags", "users"
end
