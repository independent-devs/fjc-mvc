# frozen_string_literal: true

class ProductsController < ApplicationController
  # GET /products
  def index
    @products = Product.base_on_date.not_deleted.sort_by_latest
  end

  # GET /products/black-shoes?pid=34b404d1-8104-402a-a25a-30e831712b7a
  def show
    @product = Product.single_public(params[:slug], params[:pid])

    # seo low level cache
    @seo = Rails.cache.fetch(['Products', @product.id, 'seo', @product.updated_at.to_i], expires_in: 12.hours) do
      @product.seo
    end
  rescue ActiveRecord::RecordNotFound
    render 'not_found', status: :not_found
  end
end
