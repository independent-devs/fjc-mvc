# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!, only: %i[add_to_cart]

  def index; end

  def add_to_cart; end

  def guest_add_to_cart; end
end
