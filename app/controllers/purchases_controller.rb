class PurchasesController < ApplicationController
  before_action :authenticate_user!
  def index
    @category = Category.includes(:purchases).find(params[:category_id])
    @purchases = @category.purchases.order(created_at: :desc)
    @total_purchase_amount = @category.purchases.sum(:amount)
    # @total_amount = @purchases.sum(:amount)
  end

  def new
    @category = Category.find(params[:category_id])
    @purchase = Purchase.new
  end

  def show
    @category = Category.find(params[:category_id])
    @purchase = @category.purchases
  end

  def create
    @category = Category.find(params[:category_id])
    @new_purchase = @category.purchases.new(purchase_params)
    @new_purchase.author_id = current_user.id
    if @new_purchase.save
      flash[:notice] = "#{@new_purchase.name} transaction created"
      redirect_to category_purchases_path(@category)
    else
      flash[:alert] = 'Kindly fill all required fields'
      puts @new_purchase.errors.full_messages # Add this line to print validation errors to the console
      render 'new'
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:name, :amount)
  end
end
