# frozen_string_literal: true

class Admin::DashboardController < Admin::BaseController
  def index
    @completed_orders = Order.where(order_status: { name: 'completed' }).joins(:order_status).count
    @completed_orders_prev_percent = 0.0
  end
end
