class CreatePaymentCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_categories do |t|

      t.timestamps
    end
  end
end
