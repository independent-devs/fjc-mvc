# frozen_string_literal: true

class CartsController < BaseController
  load_and_authorize_resource

  def index
    @carts = Cart.detailed.accessible_by(current_ability)
    return if params[:bn].blank?

    @carts = @carts.sort_by { |cart| cart.id == params[:bn] ? 0 : 1 }
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

  def total
    @carts = Cart.detailed.accessible_by(current_ability)
    @carts = @carts.where(id: params[:ids]) if params[:ids].present?
    @total = @carts.sum('variants.price * carts.qty')
  end

  def bulk_delete
    @carts = Cart.detailed.accessible_by(current_ability)
    @carts = @total.where(id: params[:ids]) if params[:ids].present?
    @carts.destroy_all
  end

  private

  def cart_params
    params.require(:cart).permit(:qty, :variant_id)
  end
end
