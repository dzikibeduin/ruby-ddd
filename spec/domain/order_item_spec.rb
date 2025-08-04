require 'spec_helper'
require_relative '../../domain/order/order_item'
require_relative '../../domain/order/price'
RSpec.describe OrderDomain::OrderItem do
  describe '#initialize' do
    it 'creates an order' do
      item = OrderDomain::OrderItem.new(product_id: 'product_1',
                                       quantity: 2,
                                       price: OrderDomain::Price.new(10.0))
      expect(item.product_id).to eq('product_1')
      expect(item.quantity).to eq(2)
      expect(item.price).to be(an_instance_of(OrderDomain::Price))
      expect(item.price.amount).to eq(10.0)
      expect(item.total_price).to eq(20.0)
    end
    it 'raises an error if quantity is not positive' do
      expect {
        OrderDomain::OrderItem.new(product_id: 'product_1', quantity: 0, price: OrderDomain::Price.new(10.0))
      }.to raise_error(ArgumentError, 'Quantity must be positive')
    end
    it 'raises an error if price is not positive' do
      expect {
        OrderDomain::OrderItem.new(product_id: 'product_1', quantity: 2, price: OrderDomain::Price.new(-10.0))
      }.to raise_error(ArgumentError, 'Price must be positive')
    end
    it 'raises an error if product_id is nil' do
      expect {
        OrderDomain::OrderItem.new(product_id: nil, quantity: 2, price: OrderDomain::Price.new(10.0))
      }.to raise_error(ArgumentError, 'Product ID cannot be nil')
    end
    it 'raises an error if product_id is empty' do
      expect {
        OrderDomain::OrderItem.new(product_id: '', quantity: 2, price: OrderDomain::Price.new(10.0))
      }.to raise_error(ArgumentError, 'Product ID cannot be empty')
    end
    
    it 'raises an error if price is nil' do
      expect {
        OrderDomain::OrderItem.new(product_id: 'product_1', quantity: 2, price: nil)
      }.to raise_error(ArgumentError, 'Price cannot be nil')
    end
  end
end
