require "test_helper"

class ContasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conta = contas(:one)
  end

  test "should get index" do
    get contas_url
    assert_response :success
  end

  test "should get new" do
    get new_conta_url
    assert_response :success
  end

  test "should create conta" do
    assert_difference("Conta.count") do
      post contas_url, params: { conta: { descricao: @conta.descricao, valor_inicial: @conta.valor_inicial } }
    end

    assert_redirected_to conta_url(Conta.last)
  end

  test "should show conta" do
    get conta_url(@conta)
    assert_response :success
  end

  test "should get edit" do
    get edit_conta_url(@conta)
    assert_response :success
  end

  test "should update conta" do
    patch conta_url(@conta), params: { conta: { descricao: @conta.descricao, valor_inicial: @conta.valor_inicial } }
    assert_redirected_to conta_url(@conta)
  end

  test "should destroy conta" do
    assert_difference("Conta.count", -1) do
      delete conta_url(@conta)
    end

    assert_redirected_to contas_url
  end
end
