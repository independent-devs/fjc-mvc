# frozen_string_literal: true

class Admin::StocksController < Admin::BaseController
  before_action :set_product, only: %i[
    product_stocks
    product_stock_update
    product_stock_modify
    product_stocks_movement
  ]

  # GET admin/products/1/stocks
  def product_stocks
    @variants = @product.variants.sort_by_position.not_deleted
  end

  # PUT /admin/products/1/stocks/1/update
  def product_stock_update
    respond_to do |format|
      stock_update(product_variant_params, format)
    end
  end

  def product_stock_modify
    modify_amount = product_variant_params[:modify_amount].to_i

    respond_to do |format|
      if modify_amount.zero?
        return format.turbo_stream do
          locals = { message: I18n.t('variants.invalid_modify_amount'),
                     type: nil, notif_type: 'error' }
          render :stream, locals:
        end
      end

      count_on_hand = (
        if modify_amount.positive?
          @variant.count_on_hand + modify_amount
        else
          @variant.count_on_hand - modify_amount.abs
        end
      )

      stock_update({ count_on_hand: }, format)
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

  def stock_update(stock_params, format)
    if @variant.update(stock_params)
      format.turbo_stream do
        locals = { message: I18n.t('variants.updated'), type: 'input-table', notif_type: 'success',
                   variant: @variant }
        render :stream, locals:
      end
    else
      format.turbo_stream do
        locals = { message: @variant.errors.full_messages.first, type: 'input-table',
                   notif_type: 'error', variant: @product.variants.find(params[:vid]) }
        render :stream, locals:
      end
    end
  end

  def product_variant_params
    params.require(:product_variant).permit(:sku, :count_on_hand, :trackable, :backorderable, :modify_amount)
  end
end
