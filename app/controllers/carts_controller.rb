# frozen_string_literal: true

class CartsController < BaseController
  before_action :set_guest_session, only: %i[index sync guest_update guest_destroy]
  before_action :set_cart, only: %i[update guest_update destroy guest_destroy sync]
  load_and_authorize_resource except: %i[index]

  def index
    @carts =
      (if current_user.present?
         user_carts_with_guest(@guest_session)
       else
         @guest_session.carts.not_owned.not_ordered.detailed
       end)
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

  def guest_update
    respond_to do |format|
      if @cart.update(cart_params)
        format.turbo_stream { render :update }
      else
        format.turbo_stream { render :error, :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart.destroy
  end

  def guest_destroy
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

  def set_cart
    @cart = Cart.single_using_uuid(params[:uuid])
  end

  def user_carts_with_guest(guest_session)
    if guest_session.present?
      current_user.carts.or(Cart.where(guest_session:)).not_ordered.detailed
    else
      current_user.carts.not_ordered.detailed
    end
  end

  def cart_params
    params.require(:cart).permit(:qty, :variant_id)
  end
end
