# frozen_string_literal: true

class Admin::Products::VariantsController < Admin::BaseController
  load_and_authorize_resource :product
  load_and_authorize_resource through: :product

  # GET /admin/product/:product_id/variants
  def index
    @variants = @product.variants.sort_by_position.grouped_option_name.accessible_by(current_ability)
  end

  # GET /admin/product/:product_id/variants/:id
  def show; end

  # GET /admin/product/:product_id/variants/new
  def new; end

  # POST /admin/product/:product_id/variants/:id
  def create
    @variant = Variant.new(variant_params)

    if @variant.save
      redirect_to admin_product_variants_url(@product), notice: I18n.t('variants.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/product/:product_id/variants/:id
  def update
    respond_to do |format|
      if @variant.update(variant_params)
        format.html { redirect_to admin_product_variants_url(@product), notice: I18n.t('variants.updated') }
        format.turbo_stream
      else
        format.html { render :show, status: :unprocessable_entity }
        format.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/product/:product_id/variants/:id
  def destroy
    @variant.destroy
  end

  # PATCH /admin/product/:product_id/variants/:id/position
  def position
    @variant.update(sort_order_position: variant_params[:position])

    head :ok
  end

  private

  def variant_params
    params.require(:product_variant)
          .permit(:name, :alternative_name, :cost, :price, :count_on_hand,
                  :position, :trackable, :backorderable, :sku, :product_id,
                  variant_option_values_attributes: %i[id name variant_id product_option_id position])
  end
end
