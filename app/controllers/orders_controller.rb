# frozen_string_literal: true

class OrdersController < BaseController
  load_and_authorize_resource

  def index
    @orders = Order.accessible_by(current_ability)
  end

  def show; end

  def create; end

  def cancel; end
end
