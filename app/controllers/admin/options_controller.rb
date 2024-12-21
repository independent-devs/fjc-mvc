# frozen_string_literal: true

class Admin::OptionsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @options = Option.sort_by_position.accessible_by(current_ability)
  end
end
