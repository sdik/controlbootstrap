class AddContaToRecebiveis < ActiveRecord::Migration[7.1]
  def change
    add_reference :recebiveis, :conta, null: true, foreign_key: true
  end
end
