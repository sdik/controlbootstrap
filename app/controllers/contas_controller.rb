class ContasController < ApplicationController
  before_action :set_conta, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /contas or /contas.json
  def index
    @contas = Conta.all
  end

  # GET /contas/1 or /contas/1.json
  def show
    @conta = Conta.find(params[:id])
    @recebiveis = @conta.recebiveis.where(status: true).order(data_pagamento: :desc)
    @pagamentos = @conta.pagamentos.where(status: true).order(data_pagamento: :desc)
    @transferencias_origem = @conta.transferencias_origem.order(data: :desc)
    @transferencias_destino = @conta.transferencias_destino.order(data: :desc)

    @transacoes = (@recebiveis + @pagamentos + @transferencias_origem + @transferencias_destino).sort_by do |transacao|
      if transacao.is_a?(Recebivel) || transacao.is_a?(Pagamento)
        transacao.data_pagamento || Time.at(0)
      elsif transacao.is_a?(Transferencia)
        transacao.data || Time.at(0)
      end
    end
  end

  # GET /contas/new
  def new
    @conta = Conta.new
  end

  # GET /contas/1/edit
  def edit
  end

  # POST /contas or /contas.json
  def create
    @conta = Conta.new(conta_params)

    respond_to do |format|
      if @conta.save
        format.html { redirect_to conta_url(@conta), notice: "Conta was successfully created." }
        format.json { render :show, status: :created, location: @conta }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @conta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contas/1 or /contas/1.json
  def update
    respond_to do |format|
      if @conta.update(conta_params)
        format.html { redirect_to conta_url(@conta), notice: "Conta was successfully updated." }
        format.json { render :show, status: :ok, location: @conta }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @conta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contas/1 or /contas/1.json
  def destroy
    @conta.destroy!

    respond_to do |format|
      format.html { redirect_to contas_url, notice: "Conta was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conta
      @conta = Conta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conta_params
      params.require(:conta).permit(:descricao, :valor_inicial, :cor_fundo, :cor_fonte)
    end
end
