# frozen_string_literal: true

class Admin::ImagesController < Admin::BaseController
  before_action :set_product

  # GET /images/1/variants
  def index; end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
