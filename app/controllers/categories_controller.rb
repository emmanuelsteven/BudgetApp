class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories, only: [:index]
  before_action :set_category, only: [:show]

  def index
    @categories = Category.all
  end

  def show
    # Category details can be loaded here if needed
  end

  def new
    @category = Category.new
  end

  def create
    @new_category = current_user.categories.new(category_params)
    if @new_category.save
      flash[:notice] = "#{@new_category.name} created successfully"
      redirect_to categories_path
    else
      flash[:alert] = 'Fill all required fields'
      render :new # Render instead of redirect to preserve form data
    end
  end
  def destroy
  if @new_category.destroy
    render json: { message: 'category  deleted successfully!' }
  else
    render json: { error: 'Failed to delete the category' }, status: :unprocessable_entity
  end
end


  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def set_categories
    @categories = current_user.categories.order(created_at: :desc)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  # def calculate_total_amount(categories)
  #   categories.map do |category|
  #     category.purchase_categories.sum { |cd| cd.purchase.amount }
  #   end
  # end
end
