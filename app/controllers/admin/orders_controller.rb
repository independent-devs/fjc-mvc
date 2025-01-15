# frozen_string_literal: true

class Admin::OrdersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @orders = Order.with_status.with_shipping_details.sort_by_latest.accessible_by(current_ability)
    @orders = @orders.where(order_statuses: { name: params[:status] }) if params[:status].present?

    @pagy, @orders = pagy(@orders)
  end

  def show; end

  def update_shipping_detail
    if @order.update(shipping_detail_attributes: order_params[:shipping_detail_attributes])
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
  end

  def ship
    if @order.update(order_status: OrderStatus.to_ship)
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def recieve
    if @order.update(order_status: OrderStatus.to_recieve)
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def complete
    if @order.update(order_status: OrderStatus.completed)
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def cancel
    if @order.update(order_status: OrderStatus.cancelled)
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def return
    if @order.update(order_status: OrderStatus.returned, return_reason: order_params[:return_reason])
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def refund
    if @order.update(order_status: OrderStatus.refunded, refund_reason: order_params[:refund_reason])
      redirect_to admin_order_url(@order), notice: I18n.t('orders.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order)
          .permit(:logistic_url, :logistic_ref, :refund_reason, :return_reason,
                  shipping_detail_attributes: %i[id fullname phone_no street barangay city state country postal_code])
  end
end
