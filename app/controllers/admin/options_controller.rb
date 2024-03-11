# frozen_string_literal: true

class Admin::OptionsController < Admin::BaseController
  # before_action :set_option, only: %i[show edit update destroy]

  # GET /options
  def index
    @options = Option.all
  end

  # GET /options/1
  def show; end

  # GET /options/new
  def new
    @option = Option.new
  end

  # GET /options/1/edit
  def edit; end

  # POST /options
  # def create
  #   @option = Option.new(option_params)

  #   if @option.save
  #     redirect_to @option, notice: 'Option was successfully created.'
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /options/1
  # def update
  #   if @option.update(option_params)
  #     redirect_to @option, notice: 'Option was successfully updated.', status: :see_other
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # DELETE /options/1
  # def destroy
  #   @option.destroy
  #   redirect_to options_url, notice: 'Option was successfully destroyed.', status: :see_other
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_option
    @option = Option.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def option_params
    params.require(:option).permit(:name, :option_type_id)
  end
end
