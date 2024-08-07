class Pessoa < ApplicationRecord
    has_many :pagamentos
    has_many :recebiveis
end
