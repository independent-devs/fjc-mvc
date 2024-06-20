# frozen_string_literal: true

class Products::VariantsController < BaseController
  before_action :authenticate_user!, only: %i[add_to_cart buy_now]
  before_action :set_guest_session, only: %i[guest_add_to_cart guest_buy_now]
  before_action :set_product_variant, only: %i[info add_to_cart guest_add_to_cart buy_now guest_buy_now]

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

  def buy_now; end

  def guest_buy_now; end

  private

  def cart_params
    params.require(:cart).permit(:qty)
  end

  def set_product_variant
    @product = Product.single_using_uuid(params[:product_uuid])
    return if params[:variant_uuid].blank?

    @variant = @product.variants.single_using_uuid(params[:variant_uuid])
  rescue ActiveRecord::RecordNotFound
    case action_name
    when 'info'
      render :error, status: :not_found
    end
  end

  def create_cart(parent)
    if parent.instance_of?(User) &&
       (cart = parent.carts.find_by(variant: @variant, order: nil)).present?
      return cart.update(qty: cart.qty + cart_params[:qty].to_i.abs)
    end

    if parent.instance_of?(GuestSession) &&
       (cart = parent.carts.find_by(variant: @variant, user: nil, order: nil)).present?
      return cart.update(qty: cart.qty + cart_params[:qty].to_i.abs)
    end

    parent.carts.new(qty: cart_params[:qty], variant: @variant).save
  end
end
