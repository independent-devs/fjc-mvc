# frozen_string_literal: true

class Admin::Products::StocksController < Admin::BaseController
  def index
    @variants = @product.variants.sort_by_position.not_deleted
  end

  def new; end
end
