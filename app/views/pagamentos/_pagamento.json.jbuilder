json.extract! pagamento, :id, :pessoa_id, :vencimento, :valor, :data_pagamento, :status, :valor_pago, :created_at, :updated_at
json.url pagamento_url(pagamento, format: :json)
