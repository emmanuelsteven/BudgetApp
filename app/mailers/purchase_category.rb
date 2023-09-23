class PurchaseCategory < ApplicationRecord
  belongs_to :category
  belongs_to :purchase
end
