class User < ApplicationRecord
  validates :name,
            presence: true

  validates :email,
            presence: true,
            uniqueness: true

  has_many :orders
  has_many :addresses

  def coupon_use_date(coupon)
    coupon_use = OrderItem.where(order_id: orders.pluck(:id),
                                 source_type: 'Coupon',
                                 source_id: coupon.id)
                          .order(:created_at)
                          .pluck(:created_at).first
  end

  def revenue_after_date(start_date)
    orders.where('created_at <= ?', start_date)
          .where.not(state: 'canceled')
          .sum(:total)
  end

  def order_quantity_after_date(start_date)
    orders.where('created_at <= ?', start_date)
          .where.not(state: 'canceled').count
  end
end
