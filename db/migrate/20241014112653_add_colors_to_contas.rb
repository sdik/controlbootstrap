class AddColorsToContas < ActiveRecord::Migration[7.1]
  def change
    add_column :contas, :cor_fundo, :string
    add_column :contas, :cor_fonte, :string
  end
end
