class AddContaToPagamentos < ActiveRecord::Migration[7.1]
  def change
    add_reference :pagamentos, :conta, null: true, foreign_key: true
  end
end
