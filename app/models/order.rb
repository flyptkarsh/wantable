class Order < ApplicationRecord
  BUILDING = 'building'.freeze
  ARRIVED = 'arrived'.freeze
  CANCELED = 'canceled'.freeze
  STATES = [BUILDING, ARRIVED, CANCELED].freeze

  validates_presence_of :user_id, :state

  validates   :total,
              presence: true,
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  belongs_to :user
  belongs_to :address

  has_many :order_items
  has_many :payments

  def to_param
    number
  end

  def self.search(search)
    if search
      if search[:order_number]
        Order.where(number: search[:order_number])
      elsif search[:user_email]
        user_ids = User.where(email: search[:user_email]).map(&:id)
        Order.where(user_id: user_ids)
      elsif search[:user_name]
        user_ids = User.where(name: search[:user_name]).map(&:id)
        Order.where(user_id: user_ids)
      elsif search[:order_state]
        Order.where(state: search[:order_state])
      else
        Order.all
      end
    else
      Order.all
    end
  end
end
