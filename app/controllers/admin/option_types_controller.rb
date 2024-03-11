# frozen_string_literal: true

class Admin::OptionTypesController < Admin::BaseController
  # before_action :set_option_type, only: %i[show edit update destroy]

  # GET /option_types
  def index
    @option_types = OptionType.all
  end

  # GET /option_types/1
  def show; end

  # GET /option_types/new
  def new
    @option_type = OptionType.new
  end

  # GET /option_types/1/edit
  def edit; end

  # POST /option_types
  # def create
  #   @option_type = OptionType.new(option_type_params)

  #   if @option_type.save
  #     redirect_to @option_type, notice: 'Option type was successfully created.'
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /option_types/1
  # def update
  #   if @option_type.update(option_type_params)
  #     redirect_to @option_type, notice: 'Option type was successfully updated.', status: :see_other
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # DELETE /option_types/1
  # def destroy
  #   @option_type.destroy
  #   redirect_to option_types_url, notice: 'Option type was successfully destroyed.', status: :see_other
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_option_type
    @option_type = OptionType.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def option_type_params
    params.require(:option_type).permit(:name)
  end
end
