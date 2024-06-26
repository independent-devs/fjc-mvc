# frozen_string_literal: true

class ProductsController < BaseController
  before_action :set_product, only: %i[show]

  # GET /products
  def index
    @products = Product.base_on_date.not_deleted.sort_by_latest
  end

  # GET /products/:slug?pid=:uuid
  def show
    @carousel = @product.images.all
  end

  private

  def set_product
    @product = Product.single_public(params[:slug], params[:pid])
  rescue ActiveRecord::RecordNotFound
    case action_name
    when 'show'
      render 'not_found', status: :not_found
    end
  end
end
