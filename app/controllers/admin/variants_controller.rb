# frozen_string_literal: true

class Admin::VariantsController < Admin::BaseController
  before_action :set_product, only: %i[product_variants product_variant_new product_variant_create]

  # GET /products/1/variants
  def product_variants
    @variants = @product.variants.not_master.not_deleted
  end

  # GET /products/1/variants/new
  def product_variant_new
    @variant = @product.variants.new
  end

  # POST /products/1/variants/new
  def product_variant_create
    @variant = @product.variants.new

    if @variant.save
      # redirect_to admin_product_url(@variant), notice: I18n.t('products.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
