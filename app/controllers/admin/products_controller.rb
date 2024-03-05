# frozen_string_literal: true

class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: %i[show update destroy]

  # GET /products
  def index
    @products = Product.not_deleted.sort_by_latest
  end

  # GET /products/1
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_product_url(@product), notice: I18n.t('products.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to admin_product_url(@product), notice: I18n.t('products.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    if @product.update(deleted_at: DateTime.now)
      redirect_to admin_products_url, notice: I18n.t('products.destroyed')
      return
    end

    redirect_to admin_products_url, error: I18n.t('products.unexpected')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product)
          .permit(:name, :description, :available_on, :discontinue_on, :slug,
                  :meta_description, :meta_keywords, :promotionable, :meta_title,
                  product_variants_attributes: %i[id sell_price cost_price sku is_master])
  end
end
