# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

require 'faker'

# Criar 100 pessoas
100.times do
  Pessoa.create(
    nome: Faker::Name.name,
    endereco: Faker::Address.street_address,
    bairro: Faker::Address.community,
    cidade: Faker::Address.city,
    email: Faker::Internet.email,
    telefone: Faker::PhoneNumber.phone_number
  )
end

# Criar 5 contas bancárias
5.times do
  Conta.create(
    descricao: Faker::Bank.name,
    valor_inicial: Faker::Number.decimal(l_digits: 3, r_digits: 2)
  )
end

# Criar 500 registros de pagamento
500.times do
  Pagamento.create(
    pessoa: Pessoa.order('RANDOM()').first,
    vencimento: Faker::Date.between(from: 2.years.ago, to: Date.today),
    valor: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    data_pagamento: Faker::Date.between(from: 2.years.ago, to: Date.today),
    status: [0, 1].sample,  # Supondo que 0 e 1 são possíveis status
    valor_pago: Faker::Number.decimal(l_digits: 2, r_digits: 2)
  )
end

# Criar 500 registros de recebíveis
500.times do
  Recebivel.create(
    pessoa: Pessoa.order('RANDOM()').first,
    vencimento: Faker::Date.between(from: 2.years.ago, to: Date.today),
    valor: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    data_pagamento: Faker::Date.between(from: 2.years.ago, to: Date.today),
    status: [0, 1].sample,  # Supondo que 0 e 1 são possíveis status
    valor_recebido: Faker::Number.decimal(l_digits: 2, r_digits: 2)
  )
end

# Criar 50 transferências
50.times do
  from_account = Conta.order('RANDOM()').first
  to_account = Conta.where.not(id: from_account.id).order('RANDOM()').first

  Transferencia.create(
    data: Faker::Date.between(from: 2.years.ago, to: Date.today),
    saida: from_account.id,
    valor_saida: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    entrada: to_account.id,
    valor_entrada: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    motivo: "Transferência de #{from_account.descricao} para #{to_account.descricao}"
  )
end