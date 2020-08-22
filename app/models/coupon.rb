class Coupon < ApplicationRecord
  validates_presence_of :name

  validates   :amount,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 0
              },
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  has_many :order_items,
           as: :source

  def coupon_users
    order_ids = order_items.pluck(:order_id)
    users_ids = Order.where(id: order_ids).pluck(:user_id)
    User.where(id: users_ids)
  end
end
