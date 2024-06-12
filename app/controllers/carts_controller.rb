# frozen_string_literal: true

class CartsController < BaseController
  before_action :authenticate_user!, only: %i[sync sync_all item_update destroy]
  before_action :set_guest_session, only: %i[index sync guest_item_update guest_destroy]

  def index
    @carts =
      (if current_user.present?
         user_carts_with_guest(@guest_session)
       else
         @guest_session.carts.not_owned.not_ordered.detailed
       end)
  end

  def destroy
    get_cart(current_user).destroy
  end

  def guest_destroy
    get_cart(@guest_session).destroy
  end

  def item_update
    @cart = get_cart(current_user)

    respond_to do |format|
      if @cart.update(cart_params)
        format.turbo_stream
      else
        format.turbo_stream { render :error, status: :unprocessable_entity }
      end
    end
  end

  def guest_item_update
    @cart = get_cart(@guest_session)

    respond_to do |format|
      if @cart.update(cart_params)
        format.turbo_stream { render :item_update }
      else
        format.turbo_stream { render :error, :unprocessable_entity }
      end
    end
  end

  def sync
    @cart = get_cart(@guest_session)

    respond_to do |format|
      if @cart.user.nil? && @cart.update(user: current_user)
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

  def set_variant
    @variant = Variant.single_using_uuid(params[:uuid])
  end

  def get_cart(parent)
    parent.carts.single_using_uuid(params[:uuid])
  end

  def user_carts_with_guest(guest_session)
    if guest_session.present?
      current_user.carts.or(Cart.where(guest_session:)).not_ordered.detailed
    else
      current_user.carts.not_ordered.detailed
    end
  end
end
