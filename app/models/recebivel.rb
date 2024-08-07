class Recebivel < ApplicationRecord
  belongs_to :pessoa
 # belongs_to :conta

  scope :pagos, -> { where(status: true) }
  scope :a_pagar, -> { where(status: false).or(where(status: nil)).where('vencimento >= ?', Date.today) }
  scope :vencidos, -> { where(status: false).or(where(status: nil)).where('vencimento < ?', Date.today) }
  scope :pagar_hoje, -> { where(status: false).or(where(status: nil)).where('vencimento = ?', Date.today) }
#
#  def self.ransackable_attributes(auth_object = nil)
#    %w[pessoa_id vencimento valor data_pagamento status valor_recebido conta_id created_at updated_at]
#  end

#  def self.ransackable_associations(auth_object = nil)
#    %w[pessoa conta]
#  end
end
