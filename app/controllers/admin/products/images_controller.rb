# frozen_string_literal: true

class Admin::Products::ImagesController < Admin::BaseController
  load_and_authorize_resource :product
  before_action :set_image, only: %i[show update destroy position]

  # GET /admin/product/:product_id/images
  def index; end

  def show; end

  # PATCH/PUT /admin/product/:product_id/images/:id
  def update
    respond_to do |format|
      if @image.update(product_image_params[:image])
        format.turbo_stream
      else
        format.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/product/:product_id/images/:id
  def destroy
    @image.purge
  end

  # POST /admin/product/:product_id/images/upload
  def upload
    respond_to do |format|
      if @product.update(images: product_image_params[:images])
        format.turbo_stream
      else
        format.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  # PATCH /admin/product/:product_id/images/:id/position
  def position
    @image.update(sort_order_position: product_image_params[:position])

    head :ok
  end

  private

  def set_image
    @image = @product.images.find(params[:id])
  end

  def product_image_params
    params.require(:product_image).permit(:position, :image, images: [])
  end
end
