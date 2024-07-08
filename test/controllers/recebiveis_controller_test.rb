require "test_helper"

class RecebiveisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recebivel = recebiveis(:one)
  end

  test "should get index" do
    get recebiveis_url
    assert_response :success
  end

  test "should get new" do
    get new_recebivel_url
    assert_response :success
  end

  test "should create recebivel" do
    assert_difference("Recebivel.count") do
      post recebiveis_url, params: { recebivel: { data_pagamento: @recebivel.data_pagamento, pessoa_id: @recebivel.pessoa_id, status: @recebivel.status, valor: @recebivel.valor, valor_recebido: @recebivel.valor_recebido, vencimento: @recebivel.vencimento } }
    end

    assert_redirected_to recebivel_url(Recebivel.last)
  end

  test "should show recebivel" do
    get recebivel_url(@recebivel)
    assert_response :success
  end

  test "should get edit" do
    get edit_recebivel_url(@recebivel)
    assert_response :success
  end

  test "should update recebivel" do
    patch recebivel_url(@recebivel), params: { recebivel: { data_pagamento: @recebivel.data_pagamento, pessoa_id: @recebivel.pessoa_id, status: @recebivel.status, valor: @recebivel.valor, valor_recebido: @recebivel.valor_recebido, vencimento: @recebivel.vencimento } }
    assert_redirected_to recebivel_url(@recebivel)
  end

  test "should destroy recebivel" do
    assert_difference("Recebivel.count", -1) do
      delete recebivel_url(@recebivel)
    end

    assert_redirected_to recebiveis_url
  end
end
