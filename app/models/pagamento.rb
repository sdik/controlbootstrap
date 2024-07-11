class Pagamento < ApplicationRecord
  belongs_to :pessoa
 # enum status: [:Pendente, :Pago]
end
