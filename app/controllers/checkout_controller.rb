# frozen_string_literal: true

class CheckoutController < BaseController
  load_and_authorize_resource class: 'Order', only: :show
  load_and_authorize_resource class: 'Cart', only: :proceed_checkout

  def show; end

  def proceed_checkout; end

  private

  def checkout_params
    params.require(:checkout).permit(cart_ids: [])
  end
end
