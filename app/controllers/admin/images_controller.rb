# frozen_string_literal: true

class Admin::ImagesController < Admin::BaseController
  before_action :set_product, only: %i[product_images]

  # GET /admin/product/:id/images
  def product_images
    @images = @product.images.order(:position)
  end

  # PUT /admin/product/:id/images/:mid
  def product_image_position
    @image.update(sort_order_position: product_image_params[:position])
    head :ok
  end

  private

  def set_product
    @product = Product.find(params[:id])

    return if params[:mid].blank?

    @image = ActiveStorageAttachment.find_by!(id: params[:mid], record_type: 'Product', record_id: @product.id)
  end

  def product_image_params
    params.require(:product_image).permit(:position, images: [])
  end
end
