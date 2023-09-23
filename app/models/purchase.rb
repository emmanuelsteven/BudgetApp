class Purchase < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :author_id
  belongs_to :category

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
