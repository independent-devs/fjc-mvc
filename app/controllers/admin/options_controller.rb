# frozen_string_literal: true

class Admin::OptionsController < Admin::BaseController
  before_action :set_option, only: %i[create update destroy]

  def index
    @options = Option.sort_by_position
  end

  def new
    @option = Option.new
  end

  def create
    @option = Option.new(option_params)

    if @option.save
      redirect_to admin_options_url(@option), notice: I18n.t('options.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update; end

  def destroy; end

  def position; end

  private

  def set_option
    @options = Option.find(params[:id])
  end

  def option_params
    params.require(:option).permit(:name)
  end
end
