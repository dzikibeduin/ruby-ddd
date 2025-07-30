module OrderDomain
  class Price
    attr_reader :amount

    def initialize(amount)
      raise ArgumentError, 'Amount must be a positive number' unless amount.is_a?(Numeric) && amount.positive?

      @amount = amount
    end
  end
end
