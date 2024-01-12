class CategoriesController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in

  def index
    @categories = current_user.categories.includes(:payment_categories)
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.html { render :new, locals: { category: @category } }
    end
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category created successfully.'
    else
      render :new, locals: { category: @category }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
