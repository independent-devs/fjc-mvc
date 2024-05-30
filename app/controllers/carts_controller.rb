# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!, only: %i[add_to_cart]

  # Setters
  before_action :set_guest_session, only: %i[index guest_add_to_cart]
  before_action :set_variant, only: %i[add_to_cart guest_add_to_cart]

  def index
    @guest_carts = @guest_session.carts.not_owned.not_ordered.detailed if cookies.signed[:guest_session].present?
    @carts = current_user.carts.not_ordered.detailed if current_user.present?
  end

  def add_to_cart
    respond_to do |format|
      if create_cart current_user
        format.turbo_stream
      else
        format.turbo_stream { render :error }
      end
    end
  end

  def guest_add_to_cart
    respond_to do |format|
      if create_cart @guest_session
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

  def create_cart(parent)
    if ((@cart = parent.carts.find_by(variant: @variant)).present? &&
      @cart.update(qty: @cart.qty + cart_params[:qty].to_i.abs)) ||
       parent.carts.new(qty: cart_params[:qty], variant: @variant).save

      return true
    end

    false
  end

  def set_guest_session
    if cookies.signed[:guest_session].blank?
      cookies.signed.permanent[:guest_session] = (@guest_session = GuestSession.create).id
    elsif (@guest_session = GuestSession.find_by(id: cookies.signed[:guest_session]) || GuestSession.create).new_record?
      cookies.delete :guest_session
      cookies.signed.permanent[:guest_session] = @guest_session.id
    end
  end
end
