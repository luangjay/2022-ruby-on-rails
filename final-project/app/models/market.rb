class Market < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates_numericality_of :stock, only_integer: true, greater_than_or_equal_to: 0, message: "invalid stock"
end
