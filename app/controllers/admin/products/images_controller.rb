# frozen_string_literal: true

class Admin::Products::ImagesController < Admin::BaseController
  before_action :set_product_image, only: %i[index show update destroy upload position]

  # GET /admin/product/:product_id/images
  def index
    @images = @product.images.sort_by_position.not_deleted
  end

  def show; end

  # PATCH/PUT /admin/product/:product_id/images/:id
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

  # DELETE /admin/product/:product_id/images/:id
  def destroy
    @image.purge

    respond_to do |format|
      format.turbo_stream do
        locals = { notif_type: 'success', type: 'deleted', image: @image, message: I18n.t('images.destroyed') }
        render :stream, locals:
      end
    end
  end

  # POST /admin/product/:product_id/images/upload
  def upload
    if @product.update(images: product_image_params[:images])
      redirect_to admin_product_images_url(@product), notice: I18n.t('products.updated')
    else
      redirect_to admin_product_images_url(@product), error: @product.errors.full_messages.first
    end
  end

  # PATCH /admin/product/:product_id/images/:id/position
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
