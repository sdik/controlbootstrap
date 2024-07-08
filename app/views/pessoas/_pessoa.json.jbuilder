json.extract! pessoa, :id, :nome, :endereco, :bairro, :cidade, :email, :telefone, :created_at, :updated_at
json.url pessoa_url(pessoa, format: :json)
