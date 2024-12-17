# frozen_string_literal: true

class Admin::Products::StocksController < Admin::BaseController
  before_action :set_product_stock, only: %i[index update modify]

  # GET /admin/product/:product_id/stocks
  def index
    @variants = @product.variants.sort_by_position.grouped_option_name
    @variants = @variants.master unless @product.has_variant
  end

  # PATCH/PUT /admin/product/:product_id/stocks/:id
  def update
    respond_to do |format|
      stock_update(product_variant_params, format)
    end
  end

  # PUT /admin/product/:product_id/stocks/:id/modify
  def modify
    modify_amount = product_variant_params[:modify_amount].to_i

    count_on_hand =
      (if modify_amount.positive?
         @variant.count_on_hand + modify_amount
       else
         @variant.count_on_hand - modify_amount.abs
       end)

    respond_to do |format|
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
    format.turbo_stream do
      if @variant.update(stock_params)
        locals = { message: I18n.t('stocks.updated'), type: 'item', notif_type: 'success', variant: @variant }
        render :stream, locals:
      else
        locals = { message: @variant.errors.full_messages.first, type: 'item',
                   notif_type: 'error', variant: @product.variants.find(params[:id]) }
        render :stream, locals:, status: :unprocessable_entity
      end
    end
  end
end
