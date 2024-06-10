# frozen_string_literal: true

class CartsController < ApplicationController
  # Authentication
  before_action :authenticate_user!, only: %i[
    sync_cart
    add_to_cart
    sync_all_carts
    item_update
  ]

  # Setters
  before_action :set_variant, only: %i[add_to_cart guest_add_to_cart]
  before_action :set_guest_session, only: %i[
    index
    guest_add_to_cart
    guest_item_update
  ]

  def index
    @carts =
      (if current_user.present?
         user_carts_with_guest(@guest_session)
       else
         @guest_session.carts.not_owned.not_ordered.detailed
       end)
  end

  def add_to_cart
    respond_to do |format|
      if create_cart current_user
        format.turbo_stream
      else
        format.turbo_stream { render :error, status: :unprocessable_entity }
      end
    end
  end

  def guest_add_to_cart
    respond_to do |format|
      if create_cart @guest_session
        format.turbo_stream
      else
        format.turbo_stream { render :error, status: :unprocessable_entity }
      end
    end
  end

  def item_update
    get_cart(current_user)

    respond_to do |format|
      if @cart.update(cart_params)
        format.turbo_stream
      else
        format.turbo_stream { render :error, status: :unprocessable_entity }
      end
    end
  end

  def guest_item_update
    get_cart(@guest_session)

    respond_to do |format|
      if @cart.update(cart_params)
        format.turbo_stream { render :item_update }
      else
        format.turbo_stream { render :error, :unprocessable_entity }
      end
    end
  end

  def sync_cart; end

  def sync_all_carts; end

  private

  def cart_params
    params.require(:cart).permit(:qty, :variant_id)
  end

  def update_cart
    @cart.update(cart_params)
  end

  def set_variant
    @variant = Variant.single_using_uuid(params[:uuid])
  end

  def get_cart(parent)
    @cart = parent.carts.single_using_uuid(params[:uuid])
  end

  def create_cart(parent)
    if (cart = parent.carts.find_by(variant: @variant)).present?
      return cart.update(qty: cart.qty + cart_params[:qty].to_i.abs)
    end

    parent.carts.new(qty: cart_params[:qty], variant: @variant).save
  end

  def user_carts_with_guest(guest_session)
    if guest_session.present?
      current_user.carts.or(Cart.where(guest_session:)).not_ordered.detailed
    else
      current_user.carts.not_ordered.detailed
    end
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
