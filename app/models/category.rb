class Category < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :purchases
  has_one_attached :icon, dependent: :destroy

  validates :name, presence: true
  def total_amount
    purchases.sum(:amount)
  end
end
