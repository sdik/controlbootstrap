class CreatePagamentos < ActiveRecord::Migration[7.1]
  def change
    create_table :pagamentos do |t|
      t.references :pessoa, null: false, foreign_key: true
      t.date :vencimento
      t.decimal :valor
      t.date :data_pagamento
      t.integer :status
      t.decimal :valor_pago

      t.timestamps
    end
  end
end
