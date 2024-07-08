class CreateTransferencias < ActiveRecord::Migration[7.1]
  def change
    create_table :transferencias do |t|
      t.date :data
      t.integer :saida
      t.decimal :valor_saida
      t.integer :entrada
      t.decimal :valor_entrada
      t.string :motivo

      t.timestamps
    end
  end
end
