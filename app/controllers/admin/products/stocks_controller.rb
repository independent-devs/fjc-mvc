# frozen_string_literal: true

class Admin::Products::StocksController < Admin::BaseController
  before_action :set_product_stock, only: %i[index update modify]

  def index
    @variants = @product.variants.sort_by_position.not_deleted
  end

  def update
    respond_to do |format|
      stock_update(product_variant_params, format)
    end
  end

  def modify
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

  private

  def set_product_stock
    @product = Product.find(params[:product_id])

    return if params[:id].blank?

    @variant = @product.variants.find(params[:id])
  end

  def product_variant_params
    params.require(:product_variant).permit(:sku, :count_on_hand, :trackable, :backorderable, :modify_amount)
  end

  def stock_update(stock_params, format)
    if @variant.update(stock_params)
      format.turbo_stream do
        locals = { message: I18n.t('stocks.updated'), type: 'input-table', notif_type: 'success',
                   variant: @variant }
        render :stream, locals:
      end
    else
      format.turbo_stream do
        locals = { message: @variant.errors.full_messages.first, type: 'input-table',
                   notif_type: 'error', variant: @product.variants.find(params[:vid]) }
        render :stream, locals:, status: :unprocessable_entity
      end
    end
  end
end
