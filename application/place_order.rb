require_relative '../domain/order/order'
require_relative '../domain/order/order_item'
require_relative '../domain/order/price'

module Application
  class PlaceOrder
    def initialize(order_repository)
      @repo = order_repository
    end

    def call(order_id, items_data)
      order = OrderDomain::Order.new(order_id)

      items_data.each do |item|
        price = OrderDomain::Price.new(item[:price])
        puts "Processing item: Product ID #{item[:product_id]}, Quantity #{item[:quantity]}, Price $#{price.amount}"
        order_item = OrderDomain::OrderItem.new(item[:product_id], item[:quantity], price.amount)
        order.add_item(order_item)
      end

      @repo.save(order)
      order
    end
  end
end
