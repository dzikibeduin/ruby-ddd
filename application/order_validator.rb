class OrderValidator
  def validate(order)
    if order.items.empty?
      raise ArgumentError, 'Order must have at least one item'
    end
  end
end
