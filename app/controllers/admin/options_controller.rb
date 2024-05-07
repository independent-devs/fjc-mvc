# frozen_string_literal: true

class Admin::OptionsController < Admin::BaseController
  before_action :set_option, only: %i[create update destroy]

  def index
    @options = Option.sort_by_position
  end

  def create; end

  def update; end

  def destroy; end

  private

  def set_option
    @options = Option.find(params[:id])
  end
end
