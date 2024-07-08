class RecebiveisController < ApplicationController
  before_action :set_recebivel, only: %i[ show edit update destroy ]

  # GET /recebiveis or /recebiveis.json
  def index
    @recebiveis = Recebivel.all
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
      params.require(:recebivel).permit(:pessoa_id, :vencimento, :valor, :data_pagamento, :status, :valor_recebido)
    end
end
