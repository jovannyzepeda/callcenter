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

ActiveRecord::Schema.define(version: 20161202003831) do

  create_table "campaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.index ["company_id"], name: "index_campaigns_on_company_id", using: :btree
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nombre"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "companycampaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.integer  "campaign_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_companycampaigns_on_campaign_id", using: :btree
    t.index ["company_id"], name: "index_companycampaigns_on_company_id", using: :btree
  end

  create_table "contracts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "campaign_id"
    t.date     "date"
    t.integer  "user_id"
    t.string   "season"
    t.string   "portfolio_number"
    t.string   "membership"
    t.string   "membership_number"
    t.string   "membership_size"
    t.string   "membership_type"
    t.string   "mail"
    t.float    "sell_price",           limit: 24
    t.float    "number_weeks",         limit: 24
    t.float    "price_week",           limit: 24
    t.float    "price_rent",           limit: 24
    t.string   "type"
    t.string   "owner"
    t.string   "legal_representative"
    t.string   "atipogente"
    t.float    "commission",           limit: 24
    t.string   "coowner"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["campaign_id"], name: "index_contracts_on_campaign_id", using: :btree
    t.index ["user_id"], name: "index_contracts_on_user_id", using: :btree
  end

  create_table "groupcampaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "campaign_id"
    t.integer  "group_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_groupcampaigns_on_campaign_id", using: :btree
    t.index ["group_id"], name: "index_groupcampaigns_on_group_id", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usercompanies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_usercompanies_on_company_id", using: :btree
    t.index ["user_id"], name: "index_usercompanies_on_user_id", using: :btree
  end

  create_table "usergroups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_usergroups_on_group_id", using: :btree
    t.index ["user_id"], name: "index_usergroups_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "rol"
    t.string   "nombre"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.float    "meta",                   limit: 24
    t.integer  "privilegio"
    t.integer  "status"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "campaigns", "companies"
  add_foreign_key "companycampaigns", "campaigns"
  add_foreign_key "companycampaigns", "companies"
  add_foreign_key "contracts", "campaigns"
  add_foreign_key "contracts", "users"
  add_foreign_key "groupcampaigns", "campaigns"
  add_foreign_key "groupcampaigns", "groups"
  add_foreign_key "usercompanies", "companies"
  add_foreign_key "usercompanies", "users"
  add_foreign_key "usergroups", "groups"
  add_foreign_key "usergroups", "users"
end
