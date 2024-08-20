class Transferencia < ApplicationRecord
  #  belongs_to :saida, class_name: 'Conta'
  #  belongs_to :entrada, class_name: 'Conta'

    scope :hoje, -> { where(data: Date.current) }
    scope :essa_semana, -> { where(data: Date.current.beginning_of_week..Date.current.end_of_week) }
    scope :mes_atual, -> { where(data: Date.current.beginning_of_month..Date.current.end_of_month) }

  validates :entrada, presence: true
  validates :saida, presence: true
  validates :valor_saida, presence: true, numericality: { greater_than: 0 }
  validates :data, presence: true

  validate :contas_diferentes
  validate :saldo_suficiente

  private

  # Validação para garantir que a conta de origem e destino sejam diferentes
  def contas_diferentes
    if entrada == saida
      errors.add(:conta_destino_id, "A conta de destino deve ser diferente da conta de origem")
    end
  end

  # Validação para garantir que a conta de origem tenha saldo suficiente
  def saldo_suficiente
    if Conta.find(saida).saldo.to_f < valor_saida.to_f
      errors.add(:valor_saida, "Saldo insuficiente na conta de origem")
  end
  end
end
