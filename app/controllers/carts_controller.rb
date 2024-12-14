# frozen_string_literal: true

class CartsController < BaseController
  before_action :set_guest_session, only: %i[index sync sync_all update destroy]

  load_and_authorize_resource except: :selection
  authorize_resource only: :selection

  def index
    # Buy now
    @bn = Cart.detailed.find_by(id: params[:bn], order: nil) if params[:bn].present?
    authorize! :update, @bn if @bn.present?

    @carts =
      (if @bn.present?
         Cart.detailed.where.not(id: @bn.id).accessible_by(current_ability)
       else
         Cart.detailed.accessible_by(current_ability)
       end)
  end

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.turbo_stream
      else
        format.turbo_stream { render :error, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart.destroy
  end

  def sync
    respond_to do |format|
      if (@common_cart = current_user.carts.find_by(variant_id: @cart.variant_id, order: nil)).present?
        ActiveRecord::Base.transaction do
          @common_cart.update(qty: @cart.qty + @common_cart.qty)
          @cart.destroy
        rescue ActiveRecord::RecordInvalid
          format.turbo_stream { render :error, :unprocessable_entity }
        else
          format.turbo_stream { render :sync_common }
        end
      elsif @cart.update(user: current_user)
        format.turbo_stream
      else
        format.turbo_stream { render :error, :unprocessable_entity }
      end
    end
  end

  def sync_all; end

  def variant_dropdown; end

  def selection; end

  private

  def cart_params
    params.require(:cart).permit(:qty, :variant_id)
  end
end
