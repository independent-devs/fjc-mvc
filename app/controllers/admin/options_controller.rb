# frozen_string_literal: true

class Admin::OptionsController < Admin::BaseController
  def index
    @options = Option.sort_by_position
  end
end
