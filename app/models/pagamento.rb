class Pagamento < ApplicationRecord
  belongs_to :pessoa
 # enum status: [:Pendente, :Pago]
  before_save :convert_comma_to_dot

  scope :pagos, -> { where(status: true) }
  scope :a_pagar, -> { where(status: false).or(where(status: nil)).where('vencimento >= ?', Date.today) }
  scope :vencidos, -> { where(status: false).or(where(status: nil)).where('vencimento < ?', Date.today) }
  scope :pagar_hoje, -> { where(status: false).or(where(status: nil)).where('vencimento = ?', Date.today) }
  private

  def convert_comma_to_dot
    self.valor_pago = valor_pago.to_s.gsub(',', '.').to_f if valor_pago.present?
    self.valor = valor.to_s.gsub(',', '.').to_f if valor.present?
  end
end
