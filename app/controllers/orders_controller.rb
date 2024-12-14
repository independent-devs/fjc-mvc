# frozen_string_literal: true

class OrdersController < BaseController
  before_action :set_guest_session
  load_and_authorize_resource

  def index
    @orders = Order.accessible_by(current_ability)
  end

  def show; end

  def create; end

  def cancel; end
end
