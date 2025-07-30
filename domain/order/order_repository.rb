module OrderDomain
  class OrderRepository
    def save(order)
      raise ArgumentError, 'Order must be an instance of Order' unless order.is_a?(Order)

      # Here you would implement the logic to save the order to a database or any other storage.
      # This is just a placeholder for demonstration purposes.
      puts "Order with ID #{order.id} saved successfully."
    end
  end
end
