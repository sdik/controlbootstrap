class Conta < ApplicationRecord
    has_many :recebiveis
    has_many :pagamentos
    has_many :transferencias_origem, class_name: 'Transferencia', foreign_key: 'saida'
    has_many :transferencias_destino, class_name: 'Transferencia', foreign_key: 'entrada'

    def saldo
        valor_inicial.to_d +
        recebiveis.sum(:valor_recebido) -
        pagamentos.sum(:valor) -
        transferencias_origem.sum(:valor_saida) +
        transferencias_destino.sum(:valor_saida)
    end

    def saldo_em(data)
        valor_inicial.to_d +
          recebiveis.where('data_pagamento <= ?', data).sum(:valor_recebido) -
          pagamentos.where('data_pagamento <= ?', data).sum(:valor) -
          transferencias_origem.where('data <= ?', data).sum(:valor_saida) +
          transferencias_destino.where('data <= ?', data).sum(:valor_saida)
      end
end
