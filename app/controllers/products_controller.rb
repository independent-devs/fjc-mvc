# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  # GET /products or /products.json
  def index
    @products = Product.base_on_date.has_captured_price.not_deleted.sort_by_latest
  end

  # GET /products/1 or /products/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.single_public(params[:slug])
  end
end
