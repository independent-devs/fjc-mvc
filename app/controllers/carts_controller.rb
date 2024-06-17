# frozen_string_literal: true

class CartsController < BaseController
  before_action :set_guest_session, only: %i[index sync sync_all update destroy]
  load_and_authorize_resource find_by: :uuid, id_param: :uuid

  def index
    @carts = Cart.detailed.accessible_by(current_ability)
  end

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.turbo_stream
      else
        format.turbo_stream { render :error, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart.destroy
  end

  def sync
    respond_to do |format|
      if @cart.update(user: current_user)
        format.turbo_stream
      else
        format.turbo_stream { render :unprocessable_entity }
      end
    end
  end

  def sync_all; end

  private

  def cart_params
    params.require(:cart).permit(:qty, :variant_id)
  end
end
