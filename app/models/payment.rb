class Payment < ApplicationRecord
  COMPLETED = 'completed'.freeze
  REFUNDED = 'refunded'.freeze
  STATES = [COMPLETED, REFUNDED].freeze

  CREDIT_CARD = 'CreditCard'.freeze
  STORE_CREDIT = 'StoreCredit'.freeze
  PAYMENT_TYPES = [CREDIT_CARD, STORE_CREDIT].freeze

  validates_presence_of :order_id, :state, :payment_type

  validates   :amount,
              presence: true,
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  belongs_to :order
end
