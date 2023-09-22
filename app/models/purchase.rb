class Purchase < ApplicationRecord
    belongs_to :user
    has_many :category_purchases
    has_many :categories, through: :category_purchases
  
    validates :name, :amount, presence: true

end
