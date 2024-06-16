# frozen_string_literal: true

class Admin::OrdersController < Admin::BaseController
  def index
    order = Order.all

    if params[:status].present? && (status = OrderStatus.find_by(name: params[:status])).present?
      order = order.where(order_status: status)
    end

    @pagy, @orders = pagy(order)
  end
end
