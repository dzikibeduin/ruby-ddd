module OrderDomain
  class OrderItem
    attr_reader :product_id, :quantity, :price

    def initialize(product_id, quantity, price)
      puts "Creating OrderItem with Product ID: #{product_id}, Quantity: #{quantity}, Price: #{price}"
      raise ArgumentError, 'Product ID must be a positive integer' unless product_id.is_a?(Integer) && product_id.positive?
      raise ArgumentError, 'Quantity must be a positive integer' unless quantity.is_a?(Integer) && quantity.positive?
      raise ArgumentError, 'Price must be a positive number' unless price.is_a?(Numeric) && price.positive?

      @product_id = product_id
      @quantity = quantity
      @price = price
    end

    def total_price
      @quantity * @price
    end
  end
end
