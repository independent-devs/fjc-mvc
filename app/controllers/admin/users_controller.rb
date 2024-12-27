# frozen_string_literal: true

class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @pagy, @users = pagy(User.accessible_by(current_ability))
  end
end
