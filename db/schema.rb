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

ActiveRecord::Schema.define(version: 20170202195611) do

  create_table "bootsy_image_galleries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "bootsy_resource_type"
    t.integer  "bootsy_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nombre"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "company_id"
    t.boolean  "eliminado",  default: false
    t.index ["company_id"], name: "index_campaigns_on_company_id", using: :btree
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "nombre"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "eliminado",         default: false
    t.string   "security"
    t.integer  "port"
    t.string   "password"
    t.string   "username"
    t.string   "address"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_companies_on_user_id", using: :btree
  end

  create_table "contact_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_users_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_contact_users_on_user_id", using: :btree
  end

  create_table "contactabogados", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contactabogados_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_contactabogados_on_user_id", using: :btree
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "cliente"
    t.string   "telefono"
    t.integer  "campaign_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "status"
    t.date     "date_close"
    t.boolean  "eliminado",   default: false
    t.string   "fax"
    t.string   "correo"
    t.string   "city"
    t.string   "country"
    t.string   "unit_size"
    t.string   "season"
    t.string   "resort"
    t.index ["campaign_id"], name: "index_contacts_on_campaign_id", using: :btree
  end

  create_table "contracts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "date"
    t.integer  "user_id"
    t.string   "season"
    t.string   "portfolio_number"
    t.string   "membership"
    t.string   "membership_number"
    t.string   "membership_type"
    t.string   "mail"
    t.float    "sell_price",        limit: 24
    t.float    "number_weeks",      limit: 24
    t.float    "price_week",        limit: 24
    t.float    "price_rent",        limit: 24
    t.string   "tipo"
    t.string   "owner"
    t.float    "commission",        limit: 24
    t.string   "coowner"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "contact_id"
    t.string   "lenguaje"
    t.string   "unit_size"
    t.string   "country"
    t.string   "city"
    t.string   "resort"
    t.index ["contact_id"], name: "index_contracts_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_contracts_on_user_id", using: :btree
  end

  create_table "datatemplates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "template_id"
    t.text     "content",            limit: 65535
    t.integer  "width"
    t.integer  "height"
    t.integer  "fontsize"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "left_width"
    t.string   "color"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "bold"
    t.string   "text_align"
    t.index ["template_id"], name: "index_datatemplates_on_template_id", using: :btree
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
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "eliminado",  default: false
  end

  create_table "historycontacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "contact_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content",                 limit: 65535
    t.string   "email"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "to_user"
    t.index ["contact_id"], name: "index_historycontacts_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_historycontacts_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "item_type"
    t.integer  "item_id"
    t.boolean  "viewed",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "content"
    t.index ["item_type", "item_id"], name: "index_notifications_on_item_type_and_item_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "contract_id"
    t.float    "cantidad",     limit: 24
    t.integer  "numero"
    t.integer  "user_id"
    t.boolean  "status",                  default: false
    t.date     "fecha_cierre"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["contract_id"], name: "index_payments_on_contract_id", using: :btree
    t.index ["user_id"], name: "index_payments_on_user_id", using: :btree
  end

  create_table "signempresas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "nombre"
    t.boolean  "eliminado",          default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "firma_file_name"
    t.string   "firma_content_type"
    t.integer  "firma_file_size"
    t.datetime "firma_updated_at"
    t.index ["company_id"], name: "index_signempresas_on_company_id", using: :btree
    t.index ["user_id"], name: "index_signempresas_on_user_id", using: :btree
  end

  create_table "templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.string   "lenguaje"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "papermate_file_name"
    t.string   "papermate_content_type"
    t.integer  "papermate_file_size"
    t.datetime "papermate_updated_at"
    t.string   "tipo"
    t.index ["company_id"], name: "index_templates_on_company_id", using: :btree
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
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "rol"
    t.string   "nombre"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.float    "meta",                   limit: 24
    t.integer  "privilegio"
    t.integer  "status"
    t.integer  "number"
    t.boolean  "eliminado",                         default: false
    t.string   "firma_file_name"
    t.string   "firma_content_type"
    t.integer  "firma_file_size"
    t.datetime "firma_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "campaigns", "companies"
  add_foreign_key "contact_users", "contacts"
  add_foreign_key "contact_users", "users"
  add_foreign_key "contactabogados", "contacts"
  add_foreign_key "contactabogados", "users"
  add_foreign_key "contacts", "campaigns"
  add_foreign_key "contracts", "contacts"
  add_foreign_key "contracts", "users"
  add_foreign_key "datatemplates", "templates"
  add_foreign_key "groupcampaigns", "campaigns"
  add_foreign_key "groupcampaigns", "groups"
  add_foreign_key "historycontacts", "contacts"
  add_foreign_key "historycontacts", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "signempresas", "companies"
  add_foreign_key "signempresas", "users"
  add_foreign_key "templates", "companies"
  add_foreign_key "usercompanies", "companies"
  add_foreign_key "usercompanies", "users"
  add_foreign_key "usergroups", "groups"
  add_foreign_key "usergroups", "users"
end
