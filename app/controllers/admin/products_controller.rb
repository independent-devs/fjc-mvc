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

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_product_url(@product), notice: I18n.t('products.created') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/products/1
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_product_url(@product), notice: I18n.t('products.updated') }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1
  def destroy
    respond_to do |format|
      if @product.update(deleted_at: DateTime.now)
        format.html { redirect_to admin_products_url, notice: I18n.t('products.destroyed') }
        format.turbo_stream do
          locals = { product: @product, notif_type: 'success', type: 'deleted', message: I18n.t('products.destroyed') }
          render :stream, locals:
        end
      else
        format.html { redirect_to admin_products_url, error: I18n.t('products.unexpected') }
        format.turbo_stream do
          locals = { product: @product, notif_type: 'error', type: nil, message: I18n.t('products.unexpected') }
          render :stream, locals:
        end
      end
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
                  :meta_description, :meta_keywords, :promotionable, :meta_title, :thumbnail,
                  description_attributes: %i[id description],
                  master_variant_attributes: %i[id price cost sku is_master trackable backorderable],
                  seo_attributes: %i[id meta_title meta_description meta_keywords], images: [])
  end
end
