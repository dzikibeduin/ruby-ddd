require_relative '../spec_helper'
require_relative '../../infrastructure/mongo_order_repository'
require_relative '../../domain/order/order'
require_relative '../../domain/order/order_item'
require_relative '../../domain/order/price'

RSpec.describe MongoOrderRepository do
  let(:repo) { MongoOrderRepository.new }
  let(:order_id) { 'order_1' }
  let(:item1) { OrderDomain::OrderItem.new(product_id: 'product_1', quantity: 2, price: OrderDomain::Price.new(10.0)) }
  let(:item2) { OrderDomain::OrderItem.new(product_id: 'product_2', quantity: 1, price: OrderDomain::Price.new(20.0)) }
  let(:order) { OrderDomain::Order.new(order_id).tap { |o| o.add_item(item1); o.add_item(item2) } }

  before do
    repo.save(order)
  end

  describe '#save' do
    it 'saves an order' do
      saved_order = repo.find_by_id(order_id)
      expect(saved_order).not_to be_nil
      expect(saved_order.id).to eq(order_id)
      expect(saved_order.items.size).to eq(2)

      expect(saved_order.items[0].product_id).to eq('product_1')
      expect(saved_order.items[0].quantity).to eq(2)
      expect(saved_order.items[0].price.amount).to eq(10.0)

      expect(saved_order.items[1].product_id).to eq('product_2')
      expect(saved_order.items[1].quantity).to eq(1)
      expect(saved_order.items[1].price.amount).to eq(20.0)
    end
  end
end
