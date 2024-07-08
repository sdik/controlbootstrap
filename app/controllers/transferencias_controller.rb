class TransferenciasController < ApplicationController
  before_action :set_transferencia, only: %i[ show edit update destroy ]

  # GET /transferencias or /transferencias.json
  def index
    @transferencias = Transferencia.all
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
