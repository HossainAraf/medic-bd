class UpdateOrderRangeConstraint < ActiveRecord::Migration[7.1]
  def change
    remove_check_constraint :doctors, name: 'order_range'
    add_check_constraint :doctors, "\"order\" >= 1000000 AND \"order\" <= 9999999", name: "order_range"
  end
end
