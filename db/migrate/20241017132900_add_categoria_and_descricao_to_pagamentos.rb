class AddCategoriaAndDescricaoToPagamentos < ActiveRecord::Migration[7.1]
  def change
    add_column :pagamentos, :categoria, :string
    add_column :pagamentos, :descricao, :text
  end
end
