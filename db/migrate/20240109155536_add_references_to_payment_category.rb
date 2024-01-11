class AddReferencesToPaymentCategory < ActiveRecord::Migration[7.1]
  def change
    add_reference :payment_categories, :payment, foreign_key: true
    add_reference :payment_categories, :category, foreign_key: true
  end
end
