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

ActiveRecord::Schema[7.1].define(version: 2024_10_14_112653) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contas", force: :cascade do |t|
    t.string "descricao"
    t.string "valor_inicial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cor_fundo"
    t.string "cor_fonte"
  end

  create_table "pagamentos", force: :cascade do |t|
    t.bigint "pessoa_id", null: false
    t.date "vencimento"
    t.decimal "valor"
    t.date "data_pagamento"
    t.integer "status"
    t.decimal "valor_pago"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "conta_id"
    t.index ["conta_id"], name: "index_pagamentos_on_conta_id"
    t.index ["pessoa_id"], name: "index_pagamentos_on_pessoa_id"
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "nome"
    t.string "endereco"
    t.string "bairro"
    t.string "cidade"
    t.string "email"
    t.string "telefone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recebiveis", force: :cascade do |t|
    t.bigint "pessoa_id", null: false
    t.date "vencimento"
    t.decimal "valor"
    t.date "data_pagamento"
    t.integer "status"
    t.decimal "valor_recebido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "conta_id"
    t.index ["conta_id"], name: "index_recebiveis_on_conta_id"
    t.index ["pessoa_id"], name: "index_recebiveis_on_pessoa_id"
  end

  create_table "transferencias", force: :cascade do |t|
    t.date "data"
    t.integer "saida"
    t.decimal "valor_saida"
    t.integer "entrada"
    t.decimal "valor_entrada"
    t.string "motivo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "useres", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_useres_on_email", unique: true
    t.index ["reset_password_token"], name: "index_useres_on_reset_password_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.boolean "password_set", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "pagamentos", "contas"
  add_foreign_key "pagamentos", "pessoas"
  add_foreign_key "recebiveis", "contas"
  add_foreign_key "recebiveis", "pessoas"
end
