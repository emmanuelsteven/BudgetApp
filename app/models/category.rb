class Category < ApplicationRecord
    belongs_to :user, class_name: 'User'

    has_many :purchase_categories
    has_many :purchases, through: :purchase_categories, dependent: :destroy, source: 'purchase'
 
  
    validates :name, :icon, presence: true
end
