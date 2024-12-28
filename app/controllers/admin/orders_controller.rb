# frozen_string_literal: true

class Admin::OrdersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @orders = Order.with_status.accessible_by(current_ability)
    @orders = @orders.where(order_statuses: { name: params[:status] }) if params[:status].present?

    @pagy, @orders = pagy(@orders)
  end
end
