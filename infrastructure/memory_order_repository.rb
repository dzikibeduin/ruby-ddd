require_relative '../domain/order/order_repository'

class MemoryOrderRepository < OrderDomain::OrderRepository
  def initialize
    @orders = {}
  end

  def save(order)
    raise ArgumentError, 'Order must be an instance of Order' unless order.is_a?(OrderDomain::Order)

    @orders[order.id] = order
    puts "Order with ID #{order.id} saved successfully."
  end

  def find(order_id)
    @orders[order_id]
  end

  def all
    @orders.values
  end
end
