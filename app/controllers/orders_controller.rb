# frozen_string_literal: true

class OrdersController < BaseController
  load_and_authorize_resource

  def index
    @orders = Order.accessible_by(current_ability)
    @orders = @orders.where(order_status: { name: params[:status] }).joins(:order_status) if params[:status].present?
  end

  def show; end

  def cancel; end
end
