require_relative 'order_item'

module OrderDomain
  class Order
    attr_reader :id, :items

    def initialize(id)
      raise ArgumentError, 'ID must be a positive integer' unless id.is_a?(Integer) && id.positive?

      @id = id
      @items = []
    end

    def add_item(order_item)
      raise ArgumentError, 'Order item must be an instance of OrderItem' unless order_item.is_a?(OrderItem)

      @items << order_item
    end

    def total_price
      @items.reduce(0) { |sum, item| sum + item.total_price }
    end
  end
end
