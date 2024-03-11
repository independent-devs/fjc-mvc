# frozen_string_literal: true

class Admin::VariantsController < Admin::BaseController
  before_action :set_product, only: %i[product]

  # GET /products/1/variants
  def product
    @variants = @product.variants.not_master.not_deleted
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
