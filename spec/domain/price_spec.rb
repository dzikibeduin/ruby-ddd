require 'spec_helper'
require_relative '../../domain/order/price'

RSpec.describe OrderDomain::Price do
  it 'creates a price' do
    price = OrderDomain::Price.new(10.0)
    expect(price).to be(an_instance_of(OrderDomain::Price))
    expect(price.amount).to be(10.0)
  end

  it 'raises an error if price is not positive' do
    expect(OrderDomain::Price.new(-5)).to raise_error(ArgumentError, 'Price must be positive')
  end
end
