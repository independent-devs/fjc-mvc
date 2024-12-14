# frozen_string_literal: true

class ProductsController < BaseController
  load_and_authorize_resource

  # GET /products
  def index
    @products = Product.base_on_date.sort_by_latest
  end

  # GET /products/:id
  def show
    @carousel = @product.images.all
  end
end
