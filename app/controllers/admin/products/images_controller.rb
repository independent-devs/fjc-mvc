# frozen_string_literal: true

class Admin::Products::ImagesController < Admin::BaseController
  before_action :set_product_image, only: %i[index create update destroy]

  def index
    @images = @product.images.order(:position)
  end

  def create; end

  def update; end

  def destroy; end

  private

  def set_product_image
    @product = Product.find(params[:product_id])

    return if params[:id].blank?

    @image = ActiveStorageAttachment.find_by!(id: params[:id], record_type: @product.class.name,
                                              record_id: @product.id)
  end

  def product_image_params
    params.require(:product_image).permit(:position, images: [])
  end
end
