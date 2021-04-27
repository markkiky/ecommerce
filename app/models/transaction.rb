class Transaction < ApplicationRecord
    belongs_to :order
    validates :transaction_code, uniqueness: true
end
