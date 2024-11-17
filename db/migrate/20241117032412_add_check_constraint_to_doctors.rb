class AddCheckConstraintToDoctors < ActiveRecord::Migration[7.1]
  def change
    change_column_null :doctors, :order, false
    add_check_constraint :doctors, '"order" >= 100000 AND "order" <= 9999999', name: 'order_range'
  end
end
