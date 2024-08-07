class Transferencia < ApplicationRecord
  #  belongs_to :saida, class_name: 'Conta'
  #  belongs_to :entrada, class_name: 'Conta'

    scope :hoje, -> { where(data: Date.current) }
    scope :essa_semana, -> { where(data: Date.current.beginning_of_week..Date.current.end_of_week) }
    scope :mes_atual, -> { where(data: Date.current.beginning_of_month..Date.current.end_of_month) }
end
