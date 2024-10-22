class AddCategoriaAndDescricaoToRecebiveis < ActiveRecord::Migration[7.1]
  def change
    add_column :recebiveis, :categoria, :string
    add_column :recebiveis, :descricao, :text
  end
end
