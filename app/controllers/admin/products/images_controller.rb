# frozen_string_literal: true

class Admin::Products::ImagesController < Admin::BaseController
  before_action :set_product_image, only: %i[index update destroy upload position]

  def index
    @images = @product.images.sort_by_position
  end

  def update; end

  def destroy; end

  def upload
    if @product.update(images: product_image_params[:images])
      redirect_to admin_product_images_url(@product), notice: I18n.t('products.updated')
    else
      redirect_to admin_product_images_url(@product), error: @product.errors.full_messages.first
    end
  end

  def position
    @image.update(sort_order_position: product_image_params[:position])
    head :ok
  end

  private

  def set_product_image
    @product = Product.find(params[:product_id])

    return if params[:id].blank?

    @image = @product.images.find(params[:id])
  end

  def product_image_params
    params.require(:product_image).permit(:position, images: [])
  end
end
