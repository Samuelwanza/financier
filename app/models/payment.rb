class Payment < ApplicationRecord
  belongs_to :user
  has_many :payment_categories
  validates :name, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
