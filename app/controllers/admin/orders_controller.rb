# frozen_string_literal: true

class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
    @orders = @orders.where(order_status: { name: params[:status] }).joins(:order_status) if params[:status].present?

    @pagy, @orders = pagy(@orders)
  end
end
