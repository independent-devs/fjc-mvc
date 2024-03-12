# frozen_string_literal: true

class Admin::VariantsController < Admin::BaseController
  before_action :set_product, only: %i[
    product_variants
    product_variant_new
    update_position
    product_variant_create
  ]

  # GET /products/1/variants
  def product_variants
    @variants = @product.variants.not_master.sort_by_position.not_deleted
  end

  # GET /products/1/variants/new
  def product_variant_new
    @variant = @product.variants.new
  end

  # POST /products/1/variants/new
  def product_variant_create
    @variant = @product.variants.new(product_variant_params)

    if @variant.save
      redirect_to product_admin_variants_url(@product), notice: I18n.t('variants.created')
    else
      render 'product_variant_new', status: :unprocessable_entity
    end
  end

  def update_position
    @variant = @product.variants.find(params[:vid])
    @variant.insert_at(update_position_params[:position].to_i)
    head :ok
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_variant_params
    params.require(:product_variant).permit(:cost_price, :sell_price, :sku, :count_on_hand)
  end

  def update_position_params
    params.require(:product_variant).permit(:position)
  end
end
