# frozen_string_literal: true

class CheckoutsController < BaseController
  before_action :set_order

  def show; end

  def place_order
    authorize! :place_order, @order

    if @order.update(checkout_params.merge!({ placed_at: DateTime.now }))
      redirect_to orders_url, notice: I18n.t('orders.order_placed')
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def checkout_params
    params.require(:order)
          .permit(:payment_method_id,
                  shipping_detail_attributes: %i[id fullname phone_no street barangay city state country postal_code])
  end
end
