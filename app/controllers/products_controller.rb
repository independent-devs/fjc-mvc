# frozen_string_literal: true

class ProductsController < ApplicationController
  # GET /products or /products.json
  def index
    @products = Product.base_on_date.not_deleted.sort_by_latest
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.single_public(params[:slug], params[:pid])
  rescue ActiveRecord::RecordNotFound
    render 'not_found', status: :not_found
  end
end
