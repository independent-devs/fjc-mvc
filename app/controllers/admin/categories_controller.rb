# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i[edit update destroy]

  # GET /product/categories
  def index
    @root_categories = Category.roots
  end

  # GET /product/categories/new
  def new
    @category = Category.new
  end

  # GET /product/categories/1/edit
  def edit; end

  # POST /product/categories
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_url, notice: I18n.t('categories.created') }
      else
        format.turbo_stream do
          locals = { notif_type: 'error', type: nil, message: @category.errors.full_messages.first }
          render :stream, locals:, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /product/categories/1
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_url, notice: I18n.t('categories.updated') }
        format.turbo_stream do
          locals = { notif_type: 'success', type: 'item', message: I18n.t('categories.updated'),
                     category: @category }
          render :stream, locals:
        end
      else
        format.html { redirect_to admin_categories_url, error: @category.errors.full_messages.first }
        format.turbo_stream do
          locals = { notif_type: 'error', type: 'item', message: I18n.t('categories.updated'),
                     category: find_category }
          render :stream, locals:, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /product/categories/1
  def destroy
    @category.destroy

    respond_to do |format|
      format.turbo_stream do
        locals = { category: @category, type: 'deleted', notif_type: 'success',
                   message: I18n.t('categories.destroyed') }
        render :stream, locals:
      end
    end
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
    params.require(:category).permit(:name, :parent_id, :position)
  end
end
