# frozen_string_literal: true

class ErrorsController < BaseController
  def not_found
    render status: :not_found
  end

  def internal_server_error
    render status: :internal_server_error
  end
end
