class RenameOrderToDisplayOrder < ActiveRecord::Migration[8.1]
  def change
    rename_column :doctors, :order, :display_order

    # change check_constraints name
    remove_check_constraint :doctors, name: "order_range"
    add_check_constraint :doctors,
      "display_order >= 100000 AND display_order <= 9999999",
      name: "display_order_range"
  end
end
