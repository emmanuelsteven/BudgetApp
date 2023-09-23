class Category < ApplicationRecord
    belongs_to :user, class_name: 'User'
    has_many :purchases
    has_many :purchase_categories
    has_many :purchases, through: :purchase_categories, dependent: :destroy, source: 'purchase'
    has_one_attached :icon, dependent: :destroy
 
  
    validates :name, presence: true
    def add_amount
        purchases.sum(:amount)
    end
end
