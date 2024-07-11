class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  before_save :convert_comma_to_dot

  private

  def convert_comma_to_dot
    self.valor_pago = valor_pago.to_s.gsub(',', '.').to_f if valor_pago.present?
    self.valor = valor.to_s.gsub(',', '.').to_f if valor.present?
  end
end
