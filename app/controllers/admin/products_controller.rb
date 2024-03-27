# frozen_string_literal: true

class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: %i[show update destroy]

  # GET /admin/products
  def index
    @products = Product.not_deleted.sort_by_latest
  end

  # GET /admin/products/1
  def show; end

  # GET /admin/products/new
  def new
    @product = Product.new
  end

  # POST /admin/products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_product_url(@product), notice: I18n.t('products.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/products/1
  def update
    if @product.update(product_params)
      redirect_to admin_product_url(@product), notice: I18n.t('products.updated')
    else
      render :show, status: :unprocessable_entity
    end
  end

  # DELETE /admin/products/1
  def destroy
    if @product.update(deleted_at: DateTime.now)
      redirect_to admin_products_url, notice: I18n.t('products.destroyed')
    else
      redirect_to admin_products_url, error: I18n.t('products.unexpected')
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product)
          .permit(:name, :description, :available_on, :discontinue_on, :slug, :currency,
                  :meta_description, :meta_keywords, :promotionable, :meta_title,
                  description_attributes: %i[id description],
                  variants_attributes: %i[id price cost sku is_master])
  end
end
