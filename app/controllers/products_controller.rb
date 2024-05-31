# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!, only: %i[buy_now]
  before_action :set_variant, only: %i[
    show
    buy_now
    guest_buy_now
    variant_info
  ]

  # GET /products
  def index
    @products = Product.base_on_date.not_deleted.sort_by_latest
  end

  # GET /products/:slug?pid=:uuid
  def show; end

  def variant_info; end

  def buy_now; end

  def guest_buy_now; end

  private

  def create_cart; end

  def set_variant
    set_product
    return if params[:vid].blank?

    @variant = @product.variants.single_using_uuid(params[:vid])
  rescue ActiveRecord::RecordNotFound
    case action_name
    when 'variant_info'
      render 'variant_not_found', status: :not_found
    when 'show'
      render 'not_found', status: :not_found
    end
  end

  def set_product
    @product =
      (case action_name
       when 'show'
         Product.single_public(params[:slug], params[:pid])
       else
         Product.single_using_uuid(params[:pid])
       end)
  end
end
