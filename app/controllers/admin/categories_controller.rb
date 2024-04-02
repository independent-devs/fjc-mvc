# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories
  def index
    @base_category = Category.base_root
  end

  # GET /categories/1
  def show; end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit; end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_url, notice: I18n.t('categories.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_url, notice: I18n.t('categories.updated') }
        format.turbo_stream do
          render :stream, locals: {
            notif_type: 'success',
            type: 'item',
            message: I18n.t('categories.updated'),
            category: @category
          }
        end
      else
        format.html { redirect_to admin_categories_url, error: @category.errors.full_messages.first }
        format.turbo_stream do
          render :stream, locals: {
            notif_type: 'error',
            type: 'item',
            message: I18n.t('categories.updated'),
            category: find_category
          }
        end
      end
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: I18n.t('categories.destroyed')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = find_category
  end

  def find_category(id = params[:id])
    Category.find(id)
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name)
  end
end
