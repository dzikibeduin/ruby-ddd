require_relative './application/place_order'
require_relative './infrastructure/memory_order_repository'

# Example usage
order_repository = MemoryOrderRepository.new
place_order = Application::PlaceOrder.new(order_repository)

# Sample order data
order_data = {
  order_id: 1,
  items: [
    { product_id: 101, quantity: 2, price: 19.99 },
    { product_id: 102, quantity: 1, price: 29.99 },
    { product_id: 103, quantity: 3, price: 9.99 }
  ]
}

# Place the order
  order = place_order.call(order_data[:order_id], order_data[:items])
  puts "Order placed successfully with ID: #{order.id}"
  puts "Total price: $#{order.total_price}"
