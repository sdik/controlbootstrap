class DashboadController < ApplicationController
  def index
    year = params[:year] || Time.current.year
    @dados_mes_a_mes = dados_pagamentos_e_recebiveis_por_mes(year)
    @selected_year = year
  end

  private

  def dados_pagamentos_e_recebiveis_por_mes(year)
    pagamentos = Pagamento.where(data_pagamento: Date.new(year.to_i).beginning_of_year..Date.new(year.to_i).end_of_year)
                          .group_by_month(:data_pagamento)
                          .sum(:valor_pago)
  
    recebiveis = Recebivel.where(data_pagamento: Date.new(year.to_i).beginning_of_year..Date.new(year.to_i).end_of_year)
                          .group_by_month(:data_pagamento)
                          .sum(:valor_recebido)
    meses = inicializar_meses
    pagamentos.each do |date, valor|
      mes = I18n.l(date, format: '%B').upcase
      meses[mes][:pagos] = valor
    end
    recebiveis.each do |date, valor|
      mes = I18n.l(date, format: '%B').upcase
      meses[mes][:recebidos] = valor
    end
    meses
  end

  def inicializar_meses
    {
      'JANEIRO' => { pagos: 0, recebidos: 0 },
      'FEVEREIRO' => { pagos: 0, recebidos: 0 },
      'MARÇO' => { pagos: 0, recebidos: 0 },
      'ABRIL' => { pagos: 0, recebidos: 0 },
      'MAIO' => { pagos: 0, recebidos: 0 },
      'JUNHO' => { pagos: 0, recebidos: 0 },
      'JULHO' => { pagos: 0, recebidos: 0 },
      'AGOSTO' => { pagos: 0, recebidos: 0 },
      'SETEMBRO' => { pagos: 0, recebidos: 0 },
      'OUTUBRO' => { pagos: 0, recebidos: 0 },
      'NOVEMBRO' => { pagos: 0, recebidos: 0 },
      'DEZEMBRO' => { pagos: 0, recebidos: 0 }
    }
  end
end
