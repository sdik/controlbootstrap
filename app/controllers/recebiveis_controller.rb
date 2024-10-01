class RecebiveisController < ApplicationController
  before_action :set_recebivel, only: %i[ show edit update destroy ]

  # GET /recebiveis or /recebiveis.json
  def index
        column = params[:column]
        direction = params[:direction]
        @recebiveis = Recebivel.joins(:pessoa)
    
        @items_per_page = params[:items_per_page] || 10
    
        if params[:pessoa_id].present?
          @recebiveis = @recebiveis.where(pessoa_id: params[:pessoa_id])
        end
    
        if params[:status].present?
          @recebiveis = @recebiveis.where(status: params[:status])
        end
    
        if params[:entrada_inicio].present? && params[:entrada_fim].present?
          entrada_fim = params[:entrada_fim]
          entrada_fim = Date.parse(entrada_fim) if entrada_fim.present?
          entrada_fim = entrada_fim.end_of_day if entrada_fim
          @recebiveis = @recebiveis.where(created_at: params[:entrada_inicio]..entrada_fim)
        end
    
        if params[:vencimento_inicio].present? && params[:vencimento_fim].present?
          @recebiveis = @recebiveis.where(vencimento: params[:vencimento_inicio]..params[:vencimento_fim])
        end
    
        if params[:recebivel_inicio].present? && params[:recebivel_fim].present?
          @recebiveis = @recebiveis.where(data_pagamento: params[:recebivel_inicio]..params[:recebivel_fim])
        end
    
        if column.present? && direction.present?
           if column == 'pessoa_name'
              @recebiveis = @recebiveis.order("pessoas.nome #{direction}")
           else
              @recebiveis = @recebiveis.order("#{column} #{direction}")
           end
        end
        

        @recebiveis = case params[:filter]
        when 'pagos'
          @recebiveis.pagos
        when 'a_pagar'
          @recebiveis.a_pagar
        when 'vencidos'
          @recebiveis.vencidos
        when 'pagar_hoje'
          @recebiveis.pagar_hoje 
        else
          @recebiveis.all.order(id: :desc)
        end


        @recebiveisf = @recebiveis
        @recebiveis = @recebiveis.page(params[:page]).per(@items_per_page)
  end

  def create_bulk
    numero_pagamentos = params[:numero_pagamentos].to_i
    data_inicial = Date.parse(params[:data_inicial])
    considerar_dias_uteis = params[:considerar_dias_uteis] == '1'
    pessoa_id = params[:pessoa_id]
    valor = params[:valor].to_f

    ActiveRecord::Base.transaction do
      numero_pagamentos.times do |i|
        vencimento = data_inicial + i.months

        if considerar_dias_uteis
          # Se considerar dias úteis, ajustar a data de vencimento
          vencimento = vencimento.business_day? ? vencimento : vencimento.next_business_day
        end

        Recebivel.create!(
          pessoa_id: pessoa_id,
          vencimento: vencimento,
          valor: valor
        )
      end
    end

    redirect_to recebiveis_path, notice: 'Recebíveis criados com sucesso.'
  rescue => e
    flash.now[:alert] = "Erro ao criar recebíveis: #{e.message}"
    render :index
  end 

  # GET /recebiveis/1 or /recebiveis/1.json
  def show
  end

  # GET /recebiveis/new
  def new
    @recebivel = Recebivel.new
  end

  # GET /recebiveis/1/edit
  def edit
  end

  # POST /recebiveis or /recebiveis.json
  def create
    @recebivel = Recebivel.new(recebivel_params)

    respond_to do |format|
      if @recebivel.save
        format.html { redirect_to recebivel_url(@recebivel), notice: "Recebivel was successfully created." }
        format.json { render :show, status: :created, location: @recebivel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recebivel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recebiveis/1 or /recebiveis/1.json
  def update
    respond_to do |format|
      if @recebivel.update(recebivel_params)
        format.html { redirect_to recebivel_url(@recebivel), notice: "Recebivel was successfully updated." }
        format.json { render :show, status: :ok, location: @recebivel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recebivel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recebiveis/1 or /recebiveis/1.json
  def destroy
    @recebivel.destroy!

    respond_to do |format|
      format.html { redirect_to recebiveis_url, notice: "Recebivel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recebivel
      @recebivel = Recebivel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recebivel_params
      params.require(:recebivel).permit(:pessoa_id, :vencimento, :valor, :data_pagamento, :status, :valor_recebido, :conta_id)
    end
end
