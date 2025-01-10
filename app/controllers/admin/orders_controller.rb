# frozen_string_literal: true

class Admin::OrdersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @orders = Order.with_status.accessible_by(current_ability)
    @orders = @orders.where(order_statuses: { name: params[:status] }) if params[:status].present?

    @pagy, @orders = pagy(@orders)
  end

  def show; end

  def ship
    if @order.update(order_status: Order.to_ship)
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def recieve
    if @order.update(order_status: Order.to_recieve)
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def complete
    if @order.update(order_status: Order.completed)
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def cancel
    if @order.update(order_status: Order.cancelled)
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def return
    if @order.update(order_status: Order.returned)
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def refund
    if @order.update(order_status: Order.refunded)
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:product).permit(logistic: %i[name url])
  end
end
