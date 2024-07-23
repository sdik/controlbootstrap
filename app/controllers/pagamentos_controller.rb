class PagamentosController < ApplicationController
  before_action :set_pagamento, only: %i[ show edit update destroy ]

  # GET /pagamentos or /pagamentos.json
  def index
    column = params[:column]
    direction = params[:direction]
    @pagamentos = Pagamento.joins(:pessoa)
    
    @items_per_page = params[:items_per_page] || 10

    if params[:pessoa_id].present?
      @pagamentos = @pagamentos.where(pessoa_id: params[:pessoa_id])
    end

    if params[:status].present?
      @pagamentos = @pagamentos.where(status: params[:status])
    end

    if params[:entrada_inicio].present? && params[:entrada_fim].present?
      entrada_fim = params[:entrada_fim]
      # Converta a string para um objeto Date
      entrada_fim = Date.parse(entrada_fim) if entrada_fim.present?
      # Converta para o final do dia
      entrada_fim = entrada_fim.end_of_day if entrada_fim      
      @pagamentos = @pagamentos.where(created_at: params[:entrada_inicio]..entrada_fim)
    end
    if params[:vencimento_inicio].present? && params[:vencimento_fim].present?
      @pagamentos = @pagamentos.where(vencimento: params[:vencimento_inicio]..params[:vencimento_fim])
    end
    if params[:pagamento_inicio].present? && params[:pagamento_fim].present?
      @pagamentos = @pagamentos.where(data_pagamento: params[:pagamento_inicio]..params[:pagamento_fim])
    end

    if column.present? && direction.present?
      if column == 'pessoa_name'
        @pagamentos = @pagamentos.order("pessoas.nome #{direction}")
      else
        @pagamentos = @pagamentos.order("#{column} #{direction}")
      end
    end
    
    @pagamentos = case params[:filter]
      when 'pagos'
        @pagamentos.pagos
      when 'a_pagar'
        @pagamentos.a_pagar
      when 'vencidos'
        @pagamentos.vencidos
      when 'pagar_hoje'
        @pagamentos.pagar_hoje 
      else
        @pagamentos.all
      end
   
    @pagamentosf = @pagamentos
    @pagamentos = @pagamentos.page(params[:page]).per(@items_per_page)

  end

  # GET /pagamentos/1 or /pagamentos/1.json
  def show
  end

  # GET /pagamentos/new
  def new
    @pagamento = Pagamento.new
  end

  # GET /pagamentos/1/edit
  def edit
  end

  # POST /pagamentos or /pagamentos.json
  def create
    @pagamento = Pagamento.new(pagamento_params)

    respond_to do |format|
      if @pagamento.save
        format.html { redirect_to pagamento_url(@pagamento), notice: "Pagamento Criado com Sucesso!." }
        format.json { render :show, status: :created, location: @pagamento }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pagamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pagamentos/1 or /pagamentos/1.json
  def update
    respond_to do |format|
      if @pagamento.update(pagamento_params)
        format.html { redirect_to pagamento_url(@pagamento), notice: "Pagamento Atualizado com Sucesso!" }
        format.json { render :show, status: :ok, location: @pagamento }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pagamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagamentos/1 or /pagamentos/1.json
  def destroy
    @pagamento.destroy!

    respond_to do |format|
      format.html { redirect_to pagamentos_url, notice: "Pagamento DELETADO com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pagamento
      @pagamento = Pagamento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pagamento_params
      params.require(:pagamento).permit(:pessoa_id, :vencimento, :valor, :data_pagamento, :status, :valor_pago)
    end
end
