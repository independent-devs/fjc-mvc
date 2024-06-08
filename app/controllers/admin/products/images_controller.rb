# frozen_string_literal: true

class Admin::Products::ImagesController < Admin::BaseController
  before_action :set_product_image, only: %i[index show update destroy upload position]

  # GET /admin/product/:product_id/images
  def index; end

  def show; end

  # PATCH/PUT /admin/product/:product_id/images/:id
  def update
    @image.update(product_image_params[:image])

    respond_to do |format|
      format.turbo_stream
    end
  end

  # DELETE /admin/product/:product_id/images/:id
  def destroy
    @image.purge

    respond_to do |format|
      format.turbo_stream
    end
  end

  # POST /admin/product/:product_id/images/upload
  def upload
    @product.update(images: product_image_params[:images])

    respond_to do |format|
      format.turbo_stream
    end
  end

  # PATCH /admin/product/:product_id/images/:id/position
  def position
    @image.update(sort_order_position: product_image_params[:position].to_i)
    head :ok
  end

  private

  def set_product_image
    @product = Product.find(params[:product_id])

    return if params[:id].blank?

    @image = @product.images.find(params[:id])
  end

  def product_image_params
    params.require(:product_image).permit(:position, :image, images: [])
  end
end
