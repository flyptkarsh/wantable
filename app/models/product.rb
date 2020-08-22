class Product < ApplicationRecord
  validates_presence_of :name

  validates   :sku,
              presence: true,
              uniqueness: true

  validates   :msrp,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 0
              },
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  validates   :cost,
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

  def revenue_in_date_range(start_date, end_date)
    order_items.where(created_at: start_date..end_date)
               .where.not(state: 'Returned')
               .sum(:price)
  end

  def count_in_date_range(start_date, end_date)
    order_items.where(created_at: start_date..end_date)
               .where.not(state: 'Returned')
               .sum(:quantity)
  end
end
