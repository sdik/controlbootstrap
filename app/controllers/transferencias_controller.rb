class TransferenciasController < ApplicationController
  before_action :set_transferencia, only: %i[ show edit update destroy ]
  before_action :authorize_admin
  # GET /transferencias or /transferencias.json
  def index
    column = params[:column]
    direction = params[:direction]
 
    @transferencias = Transferencia.all

    @items_per_page = params[:items_per_page] || 10

    if params[:saida].present?
      @transferencias = @transferencias.where(saida: params[:saida])
    end

    if params[:entrada].present?
      @transferencias = @transferencias.where(entrada: params[:entrada])
    end

    if params[:data_inicio].present? && params[:data_fim].present?
      data_fim = Date.parse(params[:data_fim]).end_of_day if params[:data_fim].present?
      @transferencias = @transferencias.where(data: params[:data_inicio]..data_fim)
    end

    if column.present? && direction.present?

      @transferencias = @transferencias.order("#{column} #{direction}")
    end

    @transferencias = case params[:filter]
    when 'hoje'
      @transferencias.hoje
    when 'essa_semana'
      @transferencias.essa_semana
    when 'mes_atual'
      @transferencias.mes_atual
    else
      @transferencias.all
    end
 
    @transferenciasf = @transferencias
    @transferencias = @transferencias.page(params[:page]).per(@items_per_page)
  end

  # GET /transferencias/1 or /transferencias/1.json
  def show
  end

  # GET /transferencias/new
  def new
    @transferencia = Transferencia.new
  end

  # GET /transferencias/1/edit
  def edit
  end

  # POST /transferencias or /transferencias.json
  def create
    @transferencia = Transferencia.new(transferencia_params)

    respond_to do |format|
      if @transferencia.save
        format.html { redirect_to transferencia_url(@transferencia), notice: "Transferencia was successfully created." }
        format.json { render :show, status: :created, location: @transferencia }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transferencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transferencias/1 or /transferencias/1.json
  def update
    respond_to do |format|
      if @transferencia.update(transferencia_params)
        format.html { redirect_to transferencia_url(@transferencia), notice: "Transferencia was successfully updated." }
        format.json { render :show, status: :ok, location: @transferencia }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transferencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transferencias/1 or /transferencias/1.json
  def destroy
    @transferencia.destroy!

    respond_to do |format|
      format.html { redirect_to transferencias_url, notice: "Transferencia was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transferencia
      @transferencia = Transferencia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transferencia_params
      params.require(:transferencia).permit(:data, :saida, :valor_saida, :entrada, :valor_entrada, :motivo)
    end
end
