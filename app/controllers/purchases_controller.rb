class PurchasesController < ApplicationController
  before_action :authenticate_user!
  def index
    @category = Category.includes(:purchases).find(params[:category_id])
    @purchases = @category.purchases.order(created_at: :desc)
    @total_purchase_amount = @category.purchases.sum(:amount)
  end

  def new
    @attribute = []
    @category = Category.find(params[:category_id])
    @purchase = Purchase.new
    @attribute << @purchase
    @categories = current_user.categories
    @attribute << @categories
  end

  def show
    @category = Category.find(params[:category_id])
    @purchase = @category.purchases
  end

  def create
    @category = Category.find(params[:category_id])
    @new_purchase = Purchase.new(purchase_params)
    @new_purchase.author_id = current_user.id
    @new_purchase.category_id = params[:purchase][:category_id] # Assign the selected category_id from the form

    if @new_purchase.save
      flash[:notice] = "#{@new_purchase.name} transaction created"
      redirect_to category_purchases_path(@category)
    else
      flash[:alert] = 'Kindly fill all required fields'
      puts @new_purchase.errors.full_messages
      render 'new'
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:name, :amount, :category_id)
  end
end
