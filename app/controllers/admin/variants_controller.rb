# frozen_string_literal: true

class Admin::VariantsController < Admin::BaseController
  before_action :set_product, only: %i[
    product_variants
    product_variant_new
    product_variant_create
    product_variant_update
    product_variant_delete
    product_variant_position
  ]

  # GET /admin/products/1/variants
  def product_variants
    @variants = @product.non_master_variants.sort_by_position.not_deleted
  end

  # GET /admin/products/1/variants/new
  def product_variant_new
    @variant = @product.variants.new
  end

  # POST /admin/products/1/variants/create
  def product_variant_create
    @variant = @product.variants.new(product_variant_params)

    if @variant.save
      redirect_to product_admin_variants_url(@product), notice: I18n.t('variants.created')
    else
      render :product_variant_new, status: :unprocessable_entity
    end
  end

  # PUT /admin/products/1/variants/1/update
  def product_variant_update
    respond_to do |format|
      if @variant.update(product_variant_params)
        format.turbo_stream do
          locals = { message: I18n.t('variants.updated'), type: 'input-table', notif_type: 'success',
                     variant: @variant }
          render :stream, locals:
        end
      else
        format.turbo_stream do
          locals = { message: @variant.errors.full_messages.first, type: 'input-table', notif_type: 'error',
                     variant: @product.variants.find(params[:vid]) }
          render :stream, locals:
        end
      end
    end
  end

  # DELETE /admin/products/1/variants/1/delete
  def product_variant_delete
    respond_to do |format|
      if @variant.update(deleted_at: DateTime.now)
        format.turbo_stream do
          locals = { message: I18n.t('variants.destroyed'), type: 'deleted', notif_type: 'success', variant: @variant }
          render :stream, locals:
        end
      else
        format.turbo_stream do
          locals = { message: @variant.errors.full_messages.first, type: nil, notif_type: 'error' }
          render :stream, locals:
        end
      end
    end
  end

  # PATCH /products/1/variants/1/position
  def product_variant_position
    @variant = @product.variants.find(params[:vid])
    @variant.update(sort_order_position: product_variant_params[:position].to_i)
    head :ok
  end

  private

  def set_product
    @product = Product.find(params[:id])

    return if params[:vid].blank?

    @variant = @product.variants.find(params[:vid])
  end

  def product_variant_params
    params.require(:product_variant).permit(:name, :cost, :price, :sku, :count_on_hand, :position, :trackable,
                                            :backorderable)
  end
end
