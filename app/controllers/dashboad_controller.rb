class DashboadController < ApplicationController
  include ActionView::Helpers::NumberHelper
 # before_action :authenticate_user!
  def index
    @contas = Conta.all.map do |conta|
      saldo_atual = conta.saldo
      saldo_mes_passado = conta.saldo_em(Date.today.last_month)
      tendencia = saldo_atual <=> saldo_mes_passado
      cor_fundo = conta.cor_fundo
      cor_fonte = conta.cor_fonte

      {
        conta: conta,
        saldo_atual: saldo_atual,
        saldo_mes_passado: saldo_mes_passado,
        tendencia: tendencia,
        cor_fundo: cor_fundo,
        cor_fonte: cor_fonte
      }
    end


     # Exemplo de cálculo para valores previstos e recebidos no mês atual
     @previsto_mes_atual = Recebivel.where('vencimento >= ? AND vencimento <= ?', Date.today.beginning_of_month, Date.today.end_of_month).sum(:valor)
     @recebido_mes_atual = Recebivel.where('data_pagamento >= ? AND data_pagamento <= ?', Date.today.beginning_of_month, Date.today.end_of_month).sum(:valor_recebido)
 
     # Dados formatados para os gráficos
     @dados_previsto_recebido = {
      "Previsto: #{number_to_currency(@previsto_mes_atual)}" => @previsto_mes_atual,
      "Recebido: #{number_to_currency(@recebido_mes_atual)}" => @recebido_mes_atual
      } 
  #fim 

    @receitas_por_mes = Recebivel.where('data_pagamento >= ?', 6.months.ago)
                                 .group_by_month(:data_pagamento, last: 6, format: "%B %Y")
                                 .sum(:valor_recebido)

    @despesas_por_mes = Pagamento.where('created_at >= ?', 6.months.ago)
                                 .group_by_month(:created_at, last: 6, format: "%B %Y")
                                 .sum(:valor)



    year = params[:year] || Time.current.year
    @dados_mes_a_mes = dados_pagamentos_e_recebiveis_por_mes(year)
    @selected_year = year

    @top_cities = Recebivel.joins(:pessoa)
                       .select('pessoas.cidade, COUNT(recebiveis.id) AS numero_recebimentos, SUM(recebiveis.valor) AS valor_total_recebido')
                       .group('pessoas.cidade')
                       .order('numero_recebimentos DESC')
                       .limit(10)

    mes_atual = Date.today.beginning_of_month
    mes_anterior = mes_atual - 1.month

    @recebimentos_comparacao = Recebivel.joins(:pessoa)
                                        .where("recebiveis.data_pagamento >= ? AND recebiveis.data_pagamento < ?", mes_anterior, mes_atual.next_month)
                                        .group("DATE_TRUNC('month', recebiveis.data_pagamento)")
                                        .select("DATE_TRUNC('month', recebiveis.data_pagamento) as mes, SUM(recebiveis.valor_recebido) as numero_recebimentos")
                                        .order("mes") 
    
    @dados_comparacao = {
      "Mês Atual" => @recebimentos_comparacao.find { |r| r.mes.strftime("%B %Y") == mes_atual.strftime("%B %Y") }&.numero_recebimentos || 0,
      "Mês Anterior" => @recebimentos_comparacao.find { |r| r.mes.strftime("%B %Y") == mes_anterior.strftime("%B %Y") }&.numero_recebimentos || 0
    }

    @pagamentos_comparacao = Pagamento.where("data_pagamento >= ?", mes_anterior)
                                  .group("DATE_TRUNC('month', data_pagamento)")
                                  .select("DATE_TRUNC('month', data_pagamento) as mes, SUM(valor_pago) as numero_pagamentos")
                                  .order("mes")

    @dados_comparacao_pag = {
      "Mês Atual" => @pagamentos_comparacao.find { |p| p.mes.strftime("%B %Y") == mes_atual.strftime("%B %Y") }&.numero_pagamentos || 0,
      "Mês Anterior" => @pagamentos_comparacao.find { |p| p.mes.strftime("%B %Y") == mes_anterior.strftime("%B %Y") }&.numero_pagamentos || 0
    }                              

    mes_atual = Date.today.beginning_of_month
    mes_inicio = 6.months.ago.beginning_of_month
    
    # Criando nós de Arel para as condições de comparação
    recebiveis_arel = Recebivel.arel_table
    condicao_mes_atual = recebiveis_arel['data_pagamento'].gteq(mes_atual)
    condicao_seis_meses = recebiveis_arel['data_pagamento'].gteq(mes_inicio).and(recebiveis_arel['data_pagamento'].lt(mes_atual))
    
    @dados_cidades = Recebivel.joins(:pessoa)
                              .select(
                                'pessoas.cidade',
                                "SUM(CASE WHEN #{condicao_mes_atual.to_sql} THEN 1 ELSE 0 END) AS numero_recebimentos_atual",
                                "SUM(CASE WHEN #{condicao_seis_meses.to_sql} THEN 1 ELSE 0 END) / 6.0 AS media_recebimentos"
                              )
                              .group('pessoas.cidade')
                              .order('numero_recebimentos_atual DESC')
                              .limit(10)
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
