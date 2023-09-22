class Purchase < ApplicationRecord
    belongs_to :user
    has_many :categories
    validates :name, :amount, presence: true
end
