require "application_system_test_case"

class RecebiveisTest < ApplicationSystemTestCase
  setup do
    @recebivel = recebiveis(:one)
  end

  test "visiting the index" do
    visit recebiveis_url
    assert_selector "h1", text: "Recebiveis"
  end

  test "should create recebivel" do
    visit recebiveis_url
    click_on "New recebivel"

    fill_in "Data pagamento", with: @recebivel.data_pagamento
    fill_in "Pessoa", with: @recebivel.pessoa_id
    fill_in "Status", with: @recebivel.status
    fill_in "Valor", with: @recebivel.valor
    fill_in "Valor recebido", with: @recebivel.valor_recebido
    fill_in "Vencimento", with: @recebivel.vencimento
    click_on "Create Recebivel"

    assert_text "Recebivel was successfully created"
    click_on "Back"
  end

  test "should update Recebivel" do
    visit recebivel_url(@recebivel)
    click_on "Edit this recebivel", match: :first

    fill_in "Data pagamento", with: @recebivel.data_pagamento
    fill_in "Pessoa", with: @recebivel.pessoa_id
    fill_in "Status", with: @recebivel.status
    fill_in "Valor", with: @recebivel.valor
    fill_in "Valor recebido", with: @recebivel.valor_recebido
    fill_in "Vencimento", with: @recebivel.vencimento
    click_on "Update Recebivel"

    assert_text "Recebivel was successfully updated"
    click_on "Back"
  end

  test "should destroy Recebivel" do
    visit recebivel_url(@recebivel)
    click_on "Destroy this recebivel", match: :first

    assert_text "Recebivel was successfully destroyed"
  end
end
