# frozen_string_literal: true

class Admin::StocksController < Admin::BaseController
  before_action :set_product, only: %i[product_stocks product_stocks_movement]

  # GET admin/products/1/stocks
  def product_stocks; end

  # GET admin/products/1/stocks_movement
  def product_stocks_movement; end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
