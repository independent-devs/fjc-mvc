# frozen_string_literal: true

class ProductsController < BaseController
  load_and_authorize_resource

  # GET /products
  def index
    @products = Product.base_on_date.sort_by_latest
    return if params[:category].blank?

    @products = @products.where(product_categories: { category: params[:category] }).joins(:product_categories)
  end

  # GET /products/:id
  def show
    @carousel = @product.images.sort_by_position
  end
end
