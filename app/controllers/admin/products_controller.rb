# frozen_string_literal: true

class Admin::ProductsController < Admin::BaseController
  load_and_authorize_resource

  # GET /admin/products
  def index
    @products = Product.sort_by_latest.accessible_by(current_ability)
    @pagy, @products = pagy(@products)
  end

  # GET /admin/products/1
  def show; end

  # GET /admin/products/new
  def new; end

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
    @product.destroy
  end

  private

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product)
          .permit(:name, :description, :available_on, :discontinue_on, :currency, :has_variant,
                  :meta_description, :meta_keywords, :promotionable, :meta_title, :thumbnail, :discount_percent,
                  master_variant_attributes: %i[id price cost sku is_master trackable backorderable],
                  seo_attributes: %i[id meta_title meta_description meta_keywords], images: [], option_ids: [],
                  category_ids: [])
  end
end
