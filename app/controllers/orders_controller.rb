# frozen_string_literal: true

class OrdersController < ApplicationController
  load_and_authorize_resource find_by: :uuid, id_param: :uuid, except: :checkout

  def index
    @orders = Order.accessible_by(current_ability)
  end

  def show; end

  def create; end

  def cancel; end
end
