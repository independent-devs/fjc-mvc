# frozen_string_literal: true

class Admin::Products::VariantsController < Admin::BaseController
  before_action :set_product_variant, only: %i[index new create update destroy position]

  def index
    @variants = @product.non_master_variants.sort_by_position.not_deleted
  end

  def new
    @variant = Variant.new
  end

  def create
    @variant = @product.variants.new(product_variant_params)

    if @variant.save
      redirect_to admin_product_variants_url(@product), notice: I18n.t('variants.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @variant.update(product_variant_params)
        format.turbo_stream do
          locals = { message: I18n.t('variants.updated'), type: 'item', notif_type: 'success', variant: @variant }
          render :stream, locals:
        end
      else
        format.turbo_stream do
          locals = { message: @variant.errors.full_messages.first, type: 'item', notif_type: 'error',
                     variant: @product.variants.find(params[:id]) }
          render :stream, locals:, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @variant.update(deleted_at: DateTime.now)
        format.turbo_stream do
          locals = { message: I18n.t('variants.destroyed'), type: 'deleted', notif_type: 'success', variant: @variant }
          render :stream, locals:
        end
      else
        format.turbo_stream do
          locals = { message: @variant.errors.full_messages.first, type: nil, notif_type: 'error' }
          render :stream, locals:, status: :unprocessable_entity
        end
      end
    end
  end

  def position
    @variant.update(sort_order_position: product_variant_params[:position].to_i)
    head :ok
  end

  private

  def set_product_variant
    @product = Product.find(params[:product_id])

    return if params[:id].blank?

    @variant = @product.variants.find(params[:id])
  end

  def product_variant_params
    params.require(:product_variant)
          .permit(:name, :alternative_name, :cost, :price, :sku,
                  :count_on_hand, :position, :trackable, :backorderable)
  end
end
