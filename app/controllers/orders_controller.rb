class OrdersController < ApplicationController
  before_action :find_order!, only: :show

  def index
    @orders = Order.search(search_params)
  end

  def show; end

  private

  def find_order!
    @order = Order.find_by!(number: params[:number])
  end

  def search_params
    params.permit(:user_name, :user_email, :order_number, :order_state)
  end
end
