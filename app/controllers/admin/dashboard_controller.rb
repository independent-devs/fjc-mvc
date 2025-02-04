# frozen_string_literal: true

class Admin::DashboardController < Admin::BaseController
  def index
    @placed_orders = Order.where.not(placed_at: nil).count
  end
end
