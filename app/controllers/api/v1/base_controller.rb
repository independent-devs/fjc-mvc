# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  rescue_from CanCan::AccessDenied do |_exception|
    render json: { head: :forbidden }
  end
end
