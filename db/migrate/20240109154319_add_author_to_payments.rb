class AddAuthorToPayments < ActiveRecord::Migration[7.1]
  def change
    add_reference :payments, :author, foreign_key: { to_table: :users }, null: false
  end
end
