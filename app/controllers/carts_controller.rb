# frozen_string_literal: true

class CartsController < BaseController
  before_action :set_guest_session, except: :variant_dropdown

  load_and_authorize_resource

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
      if (@common_cart = current_user.carts.find_by(variant_id: @cart.variant_id)).present?
        ActiveRecord::Base.transaction do
          @common_cart.update(qty: @cart.qty + @common_cart.qty)
          @cart.destroy
        rescue ActiveRecord::RecordInvalid
          format.turbo_stream { render :error, :unprocessable_entity }
        else
          format.turbo_stream { render :sync_common }
        end
      elsif @cart.update(user: current_user, guest_session: nil)
        format.turbo_stream
      else
        format.turbo_stream { render :error, :unprocessable_entity }
      end
    end
  end

  def sync_all; end

  def variant_dropdown; end

  private

  def cart_params
    params.require(:cart).permit(:qty, :variant_id)
  end
end
