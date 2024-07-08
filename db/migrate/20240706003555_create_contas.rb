class CreateContas < ActiveRecord::Migration[7.1]
  def change
    create_table :contas do |t|
      t.string :descricao
      t.string :valor_inicial

      t.timestamps
    end
  end
end
