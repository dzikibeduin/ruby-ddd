Sequel.migration do
  change do
    create_table(:orders) do
      primary_key :id
    end

    create_table(:order_items) do
      primary_key :id
      foreign_key :order_id, :orders
      String :product_id
      Integer :quantity
      Integer :price
    end
  end
end
