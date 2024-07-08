class CreateRecebiveis < ActiveRecord::Migration[7.1]
  def change
    create_table :recebiveis do |t|
      t.references :pessoa, null: false, foreign_key: true
      t.date :vencimento
      t.decimal :valor
      t.date :data_pagamento
      t.integer :status
      t.decimal :valor_recebido

      t.timestamps
    end
  end
end
