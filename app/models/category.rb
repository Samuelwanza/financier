class Category < ApplicationRecord
  belongs_to :user
  has_many :payment_categories
  validates :name, presence: true
  validates :icon, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
end
