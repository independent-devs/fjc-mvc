# frozen_string_literal: true

class HomeController < BaseController
  def index
    @categories = Category.all
  end
end
