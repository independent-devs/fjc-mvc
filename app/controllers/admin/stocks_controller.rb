# frozen_string_literal: true

class Admin::StocksController < Admin::BaseController
  before_action :set_product, only: %i[
    product_stocks
    product_stock_update
    product_stocks_movement
  ]

  # GET admin/products/1/stocks
  def product_stocks
    @variants = @product.non_master_variants.sort_by_position.not_deleted
  end

  # PUT /admin/products/1/stocks/1/update
  def product_stock_update
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

  # GET admin/products/1/stocks_movement
  def product_stocks_movement; end

  private

  def set_product
    @product = Product.find(params[:id])

    return if params[:vid].blank?

    @variant = @product.variants.find(params[:vid])
  end

  def product_variant_params
    params.require(:product_variant).permit(:sku, :count_on_hand, :trackable, :backorderable)
  end
end
