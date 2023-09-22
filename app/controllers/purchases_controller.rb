class PurchasesController < ApplicationController
    before_action :authenticate_user!
    def index
      @category = Category.find(params[:category_id])
      @purchases = @category.purchases.order(created_at: :desc)
      @total_amount = @purchases.sum(:amount)
    end

  def new
    @purchase = Purchase.new
  end

  def create
    @new_purchase = current_user.purchases.new(purchase_params)
    if @new_purchase.save
      CategoryPurchase.create(category_id: params[:category_id], purchase_id: @new_purchase.id)
      flash[:notice] = "#{@new_purchase.name} transaction created"
      redirect_to category_purchases_path(user_id: current_user.id, category_id: params[:category_id])
    else
      flash[:alert] = 'Kindly fill all required fields'
      
      redirect_to new_category_purchase_path(user_id: current_user.id, category_id: params[:category_id])
    end
  end
  

  private

  def purchase_params
    params.require(:purchase).permit(:name, :amount)
  end 
end
