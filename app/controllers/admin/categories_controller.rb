# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  load_and_authorize_resource

  # GET /product/categories
  def index
    @root_categories = Category.roots.order_by_name.accessible_by(current_ability)
  end

  # GET /product/categories/new
  def new; end

  # GET /product/categories/1/edit
  def edit; end

  # POST /product/categories
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_url, notice: I18n.t('categories.created') }
      else
        format.turbo_stream { render :stream, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product/categories/1
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_url, notice: I18n.t('categories.updated') }
      else
        format.html { redirect_to admin_categories_url }
        format.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product/categories/1
  def destroy
    @category.destroy
  end

  private

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :parent_id, :position)
  end
end
