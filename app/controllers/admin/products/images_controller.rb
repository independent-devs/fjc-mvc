# frozen_string_literal: true

class Admin::Products::ImagesController < Admin::BaseController
  before_action :set_product_image, only: %i[index update destroy upload position]

  def index
    @images = @product.images.sort_by_position.not_deleted
  end

  def update
    respond_to do |format|
      if @image.update(product_image_params)
        format.turbo_stream do
          render :stream, locals: { notif_type: 'success', type: nil, message: I18n.t('images.updated') }
        end
      else
        format.turbo_stream do
          render :stream, locals: { notif_type: 'error', type: 'deleted', message: @image.errors.full_messages.first }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @image.update(deleted_at: DateTime.now)
        format.turbo_stream do
          render :stream, locals: { notif_type: 'deleted', type: nil, message: I18n.t('images.destroyed') }
        end
      else
        format.turbo_stream do
          render :stream,
                 locals: { notif_type: 'error', type: 'deleted', message: @image.errors.full_messages.first }
        end
      end
    end
  end

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
    params.require(:product_image).permit(:position, :record_owner_type, :record_owner_id, images: [])
  end
end
