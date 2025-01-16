# frozen_string_literal: true

class OrdersController < BaseController
  load_and_authorize_resource

  def index
    @orders = Order.with_status.sort_by_latest.accessible_by(current_ability)
    @orders = @orders.where(order_statuses: { name: params[:status] }) if params[:status].present?
  end

  def show; end

  def cancel
    respond_to do |format|
      if @order.update(order_status: OrderStatus.cancelled)
        format.turbo_stream
      else
        format.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end
end
