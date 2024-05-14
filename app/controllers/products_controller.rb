# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_variant, only: %i[buy_now add_to_cart]

  # GET /products
  def index
    @products = Product.base_on_date.not_deleted.sort_by_latest
  end

  # GET /products/black-shoes?pid=34b404d1-8104-402a-a25a-30e831712b7a
  def show
    @product = Product.single_public(params[:slug], params[:pid])
  rescue ActiveRecord::RecordNotFound
    render 'not_found', status: :not_found
  end

  def buy_now; end

  def add_to_cart; end

  private

  def create_cart; end

  def set_variant
    @product = Product.using_uuid(params[:pid])

    return if params[:vid].blank?

    @variant = @product.variants.find(params[:vid])
  end
end
