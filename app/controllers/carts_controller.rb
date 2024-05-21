# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart_session, only: %i[guest_add_to_cart]
  before_action :authenticate_user!, only: %i[add_to_cart]
  before_action :set_variant, only: %i[add_to_cart guest_add_to_cart]

  def index; end

  def add_to_cart
    @cart = current_user.carts.new(qty: cart_params[:qty], variant: @variant)

    respond_to do |format|
      if @cart.save
        format.turbo_stream
      else
        format.turbo_stream { render :error }
      end
    end
  end

  def guest_add_to_cart
    @cart = @cart_session.carts.new(qty: cart_params[:qty], variant: @variant)

    respond_to do |format|
      if @cart.save
        format.turbo_stream
      else
        format.turbo_stream { render :error }
      end
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:qty)
  end

  def set_variant
    @variant = Variant.single_using_uuid(params[:uuid])
  end

  def set_cart_session
    if cookies.signed[:cart_session].blank?
      @cart_session = CartSession.create

      cookies.signed.permanent[:cart_session] = @cart_session.id
    else
      @cart_session = CartSession.find(cookies.signed[:cart_session])
    end
  end
end
