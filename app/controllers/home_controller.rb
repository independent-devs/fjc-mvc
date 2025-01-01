# frozen_string_literal: true

class HomeController < BaseController
  def index
    @categories = Category.all

    @products = Product.base_on_date.sort_by_latest
  end
end
