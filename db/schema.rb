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

ActiveRecord::Schema.define(version: 20) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "field_calcs", force: :cascade do |t|
    t.integer "field_id"
    t.text    "content"
    t.index ["field_id"], name: "index_field_calcs_on_field_id", using: :btree
  end

  create_table "field_opts", force: :cascade do |t|
    t.integer "field_id"
    t.string  "name",     limit: 64
    t.integer "position",            default: 0, null: false
    t.index ["field_id", "name"], name: "index_field_opts_on_field_id_and_name", unique: true, using: :btree
    t.index ["field_id"], name: "index_field_opts_on_field_id", using: :btree
    t.index ["name"], name: "index_field_opts_on_name", using: :btree
    t.index ["position"], name: "index_field_opts_on_position", using: :btree
  end

  create_table "field_types", force: :cascade do |t|
    t.string  "name",         limit: 32,             null: false
    t.integer "fields_count",            default: 0, null: false
    t.index ["name"], name: "index_field_types_on_name", unique: true, using: :btree
  end

  create_table "fields", force: :cascade do |t|
    t.integer "section_id"
    t.integer "field_type_id"
    t.string  "name",             limit: 64
    t.string  "default",          limit: 255
    t.integer "field_opts_count",             default: 0, null: false
    t.integer "position",                     default: 0, null: false
    t.index ["field_type_id"], name: "index_fields_on_field_type_id", using: :btree
    t.index ["name"], name: "index_fields_on_name", using: :btree
    t.index ["position"], name: "index_fields_on_position", using: :btree
    t.index ["section_id", "name"], name: "index_fields_on_section_id_and_name", unique: true, using: :btree
    t.index ["section_id"], name: "index_fields_on_section_id", using: :btree
  end

  create_table "folders", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name",      limit: 64,                    null: false
    t.string  "fg",        limit: 6,  default: "000000", null: false
    t.string  "bg",        limit: 6,  default: "ffffff", null: false
    t.boolean "collapsed",            default: false,    null: false
    t.integer "position",             default: 0,        null: false
    t.index ["position"], name: "index_folders_on_position", using: :btree
    t.index ["user_id"], name: "index_folders_on_user_id", using: :btree
  end

  create_table "forms", force: :cascade do |t|
    t.integer "project_id"
    t.string  "name",          limit: 64,             null: false
    t.integer "records_count",            default: 0, null: false
    t.integer "position",                 default: 0, null: false
    t.index ["name"], name: "index_forms_on_name", using: :btree
    t.index ["position"], name: "index_forms_on_position", using: :btree
    t.index ["project_id", "name"], name: "index_forms_on_project_id_and_name", unique: true, using: :btree
    t.index ["project_id"], name: "index_forms_on_project_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.integer "form_id"
    t.string  "name",     limit: 64,             null: false
    t.integer "position",            default: 0, null: false
    t.index ["form_id", "name"], name: "index_pages_on_form_id_and_name", unique: true, using: :btree
    t.index ["form_id"], name: "index_pages_on_form_id", using: :btree
    t.index ["name"], name: "index_pages_on_name", using: :btree
    t.index ["position"], name: "index_pages_on_position", using: :btree
  end

  create_table "project_folders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.integer "folder_id"
    t.index ["folder_id"], name: "index_project_folders_on_folder_id", using: :btree
    t.index ["project_id"], name: "index_project_folders_on_project_id", using: :btree
    t.index ["user_id", "project_id", "folder_id"], name: "user_proj_fold", unique: true, using: :btree
    t.index ["user_id"], name: "index_project_folders_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string  "name",          limit: 64,                 null: false
    t.integer "surveys_count",            default: 0,     null: false
    t.integer "forms_count",              default: 0,     null: false
    t.boolean "deleted",                  default: false
    t.index ["deleted"], name: "index_projects_on_deleted", using: :btree
    t.index ["name"], name: "index_projects_on_name", using: :btree
  end

  create_table "records", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "form_id"
    t.integer  "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_records_on_form_id", using: :btree
    t.index ["survey_id"], name: "index_records_on_survey_id", using: :btree
    t.index ["user_id"], name: "index_records_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.index ["name"], name: "index_relationships_on_name", unique: true, using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.integer "page_id"
    t.string  "name",         limit: 64
    t.integer "fields_count",            default: 0, null: false
    t.integer "position",                default: 0, null: false
    t.index ["name"], name: "index_sections_on_name", using: :btree
    t.index ["page_id", "name"], name: "index_sections_on_page_id_and_name", unique: true, using: :btree
    t.index ["page_id"], name: "index_sections_on_page_id", using: :btree
    t.index ["position"], name: "index_sections_on_position", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "survey_forms", force: :cascade do |t|
    t.integer "survey_id"
    t.integer "form_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "name",          limit: 64,                 null: false
    t.boolean  "active",                   default: false, null: false
    t.integer  "records_count",            default: 0,     null: false
    t.integer  "position",                 default: 0,     null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["active"], name: "index_surveys_on_active", using: :btree
    t.index ["name"], name: "index_surveys_on_name", using: :btree
    t.index ["position"], name: "index_surveys_on_position", using: :btree
    t.index ["project_id"], name: "index_surveys_on_project_id", using: :btree
  end

  create_table "token_types", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.index ["name"], name: "index_token_types_on_name", unique: true, using: :btree
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.integer "relationship_id"
    t.index ["project_id"], name: "index_user_projects_on_project_id", using: :btree
    t.index ["relationship_id"], name: "index_user_projects_on_relationship_id", using: :btree
    t.index ["user_id", "project_id", "relationship_id"], name: "user_proj_rel", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_projects_on_user_id", using: :btree
  end

  create_table "user_tokens", force: :cascade do |t|
    t.integer "user_id"
    t.integer "token_type_id"
    t.string  "token",         limit: 80
    t.index ["token"], name: "index_user_tokens_on_token", using: :btree
    t.index ["user_id", "token_type_id"], name: "index_user_tokens_on_user_id_and_token_type_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",       limit: 64,                 null: false
    t.string   "p_salt",      limit: 80
    t.string   "p_hash",      limit: 80
    t.string   "fname",       limit: 32
    t.string   "lname",       limit: 32
    t.boolean  "email_valid",            default: false, null: false
    t.boolean  "disabled",               default: false, null: false
    t.boolean  "deleted",                default: false, null: false
    t.datetime "last_login"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["deleted"], name: "index_users_on_deleted", using: :btree
    t.index ["disabled"], name: "index_users_on_disabled", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["email_valid"], name: "index_users_on_email_valid", using: :btree
    t.index ["last_login"], name: "index_users_on_last_login", using: :btree
  end

  create_table "values", force: :cascade do |t|
    t.integer  "record_id"
    t.integer  "field_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_id"], name: "index_values_on_field_id", using: :btree
    t.index ["record_id", "field_id"], name: "index_values_on_record_id_and_field_id", unique: true, using: :btree
    t.index ["record_id"], name: "index_values_on_record_id", using: :btree
  end

  add_foreign_key "field_calcs", "fields"
  add_foreign_key "field_opts", "fields"
  add_foreign_key "fields", "field_types"
  add_foreign_key "fields", "sections"
  add_foreign_key "folders", "users"
  add_foreign_key "forms", "projects"
  add_foreign_key "pages", "forms"
  add_foreign_key "project_folders", "folders"
  add_foreign_key "project_folders", "projects"
  add_foreign_key "project_folders", "users"
  add_foreign_key "records", "forms"
  add_foreign_key "records", "surveys"
  add_foreign_key "records", "users"
  add_foreign_key "sections", "pages"
  add_foreign_key "surveys", "projects"
  add_foreign_key "user_projects", "projects"
  add_foreign_key "user_projects", "relationships"
  add_foreign_key "user_projects", "users"
  add_foreign_key "user_tokens", "token_types"
  add_foreign_key "user_tokens", "users"
  add_foreign_key "values", "fields"
  add_foreign_key "values", "records"
end
