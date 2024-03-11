# frozen_string_literal: true

class Admin::VariantsController < Admin::BaseController
  before_action :set_product, only: %i[product_variants]

  # GET /products/1/variants
  def product_variants
    @variants = @product.variants.not_master.not_deleted
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
