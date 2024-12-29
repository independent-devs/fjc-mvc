# frozen_string_literal: true

class OrdersController < BaseController
  load_and_authorize_resource

  def index
    @orders = Order.with_status.accessible_by(current_ability)
    @orders = @orders.where(order_statuses: { name: params[:status] }) if params[:status].present?
  end

  def show; end

  def cancel; end
end
