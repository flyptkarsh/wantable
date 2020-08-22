class ReportsController < ApplicationController
  def index
    @coupons = Coupon.order(:name)
  end

  def coupon_users
    @coupon = Coupon.find(params[:coupon_id])
    @coupon_users = @coupon.coupon_users
  end

  def sales_by_product
    @products = Product.all
    set_dates
  end

  private

  def set_dates
    if params[:start_date] && params[:end_date]
      @start_date = flatten_date_array(params[:start_date])
      @end_date = flatten_date_array(params[:end_date])
    else
      @start_date = Date.today - 1.year
      @end_date = Date.today
    end
  end

  def flatten_date_array(hash)
    date_arr = %w[1 2 3].map { |e| hash["date(#{e}i)"].to_i }
    Date.new(date_arr[0], date_arr[1], date_arr[2])
  end
end
