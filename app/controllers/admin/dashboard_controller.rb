# frozen_string_literal: true

class Admin::DashboardController < Admin::BaseController
  def index
    @placed_orders = Order.where.not(placed_at: nil).count
    @placed_orders_prev_percent = 0.0
  end
end
