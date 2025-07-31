require 'spec_helper'
require_relative '../../domain/order/order'
require_relative '../../domain/order/order_item'
require_relative '../../domain/order/price'

RSpec.describe OrderDomain::Order do
  it 'calculates total price crrectly' do
    order = OrderDomain::Order.new('order_1')
    price = OrderDomain::Price.new(10.0)
    item = OrderDomain::OrderItem.new(product_id: 'product_1', quantity: 3, price.amount)

    order.add_item(item)

    expect(order.total_price).to eq(30.0)
  end
end
