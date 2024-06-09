# frozen_string_literal: true

class Admin::Products::VariantsController < Admin::BaseController
  before_action :set_product_variant, only: %i[index new show create update destroy position]

  # GET /admin/product/:product_id/variants
  def index
    @variants = @product.non_master_variants.sort_by_position.grouped_option_name
  end

  # GET /admin/product/:product_id/variants/:id
  def show; end

  # GET /admin/product/:product_id/variants/new
  def new
    @variant = Variant.new
  end

  # POST /admin/product/:product_id/variants/:id
  def create
    @variant = @product.variants.new(product_variant_params)

    if @variant.save
      redirect_to admin_product_variants_url(@product), notice: I18n.t('variants.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/product/:product_id/variants/:id
  def update
    respond_to do |format|
      if @variant.update(product_variant_params)
        format.html { redirect_to admin_product_variants_url(@product), notice: I18n.t('variants.updated') }
      else
        format.html { render :show, status: :unprocessable_entity }
      end

      format.turbo_stream
    end
  end

  # DELETE /admin/product/:product_id/variants/:id
  def destroy
    @variant.destroy
  end

  # PATCH /admin/product/:product_id/variants/:id/position
  def position
    @variant.update(sort_order_position: product_variant_params[:position].to_i)
    head :ok
  end

  private

  def set_product_variant
    @product = Product.find(params[:product_id])

    return if params[:id].blank?

    @variant = @product.variants.not_master.find(params[:id])
  end

  def product_variant_params
    params.require(:product_variant)
          .permit(:name, :alternative_name, :cost, :price, :count_on_hand,
                  :position, :trackable, :backorderable, :sku,
                  variant_option_values_attributes: %i[id name variant_id product_option_id position])
  end
end
