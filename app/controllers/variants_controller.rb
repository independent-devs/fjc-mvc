# frozen_string_literal: true

class VariantsController < BaseController
  before_action :set_guest_session, only: %i[guest_add_to_cart guest_buy_now]

  load_and_authorize_resource

  def info; end

  def add_to_cart
    respond_to do |format|
      if create_cart(current_user)
        format.turbo_stream { render locals: { message: I18n.t('carts.user_added_cart') } }
      else
        format.turbo_stream { render :error, status: :unprocessable_entity }
      end
    end
  end

  def guest_add_to_cart
    respond_to do |format|
      if create_cart(@guest_session)
        format.turbo_stream { render :add_to_cart, locals: { message: I18n.t('carts.guest_added_cart') } }
      else
        format.turbo_stream { render :error, status: :unprocessable_entity }
      end
    end
  end

  def buy_now
    respond_to do |format|
      if create_cart(current_user)
        format.html { redirect_to carts_url(bn: @cart.id) }
      else
        format.turbo_stream { render :error, status: :unprocessable_entity }
      end
    end
  end

  def guest_buy_now
    respond_to do |format|
      if create_cart(@guest_session)
        format.html { redirect_to carts_url(bn: @cart.id) }
      else
        format.turbo_stream { render :error, status: :unprocessable_entity }
      end
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:qty)
  end

  def create_cart(parent)
    return nil unless parent.instance_of?(User) || parent.instance_of?(GuestSession)

    if parent.instance_of?(User) &&
       (@cart = parent.carts.find_by(variant: @variant, order: nil)).present?
      return @cart.update(qty: @cart.qty + cart_params[:qty].to_i.abs)
    end

    if parent.instance_of?(GuestSession) &&
       (@cart = parent.carts.find_by(variant: @variant, user: nil, order: nil)).present?
      return @cart.update(qty: @cart.qty + cart_params[:qty].to_i.abs)
    end

    (@cart = parent.carts.new(qty: cart_params[:qty], variant: @variant)).save && @cart.reload
  end
end
