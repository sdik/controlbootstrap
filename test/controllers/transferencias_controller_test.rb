require "test_helper"

class TransferenciasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transferencia = transferencias(:one)
  end

  test "should get index" do
    get transferencias_url
    assert_response :success
  end

  test "should get new" do
    get new_transferencia_url
    assert_response :success
  end

  test "should create transferencia" do
    assert_difference("Transferencia.count") do
      post transferencias_url, params: { transferencia: { data: @transferencia.data, entrada: @transferencia.entrada, motivo: @transferencia.motivo, saida: @transferencia.saida, valor_entrada: @transferencia.valor_entrada, valor_saida: @transferencia.valor_saida } }
    end

    assert_redirected_to transferencia_url(Transferencia.last)
  end

  test "should show transferencia" do
    get transferencia_url(@transferencia)
    assert_response :success
  end

  test "should get edit" do
    get edit_transferencia_url(@transferencia)
    assert_response :success
  end

  test "should update transferencia" do
    patch transferencia_url(@transferencia), params: { transferencia: { data: @transferencia.data, entrada: @transferencia.entrada, motivo: @transferencia.motivo, saida: @transferencia.saida, valor_entrada: @transferencia.valor_entrada, valor_saida: @transferencia.valor_saida } }
    assert_redirected_to transferencia_url(@transferencia)
  end

  test "should destroy transferencia" do
    assert_difference("Transferencia.count", -1) do
      delete transferencia_url(@transferencia)
    end

    assert_redirected_to transferencias_url
  end
end
