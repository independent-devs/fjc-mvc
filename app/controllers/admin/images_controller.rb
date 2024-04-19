# frozen_string_literal: true

class Admin::ImagesController < Admin::BaseController
  before_action :set_product, only: %i[product_images]

  # GET /admin/images/1/variants
  def product_images
    @images = @product.images.order(:position)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
