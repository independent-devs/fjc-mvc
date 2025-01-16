# frozen_string_literal: true

class CheckoutsController < BaseController
  before_action :set_order

  def show
    authorize! :read, @order
  end

  def shipping_details
    authorize! :shipping_details, @order

    if @order.update(shipping_details_params)
      redirect_to checkout_url(@order), notice: I18n.t('orders.shipping_details_added')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def payment_method
    authorize! :payment_method, @order

    if @order.update(payment_method_params.merge!({ placed_at: DateTime.now }))
      redirect_to orders_url, notice: I18n.t('orders.payment_addded')
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def shipping_details_params
    params.require(:order)
          .permit(shipping_detail_attributes: %i[id fullname phone_no street barangay city state country postal_code])
  end

  def payment_method_params
    params.require(:order).permit(:payment_method_id)
  end
end
