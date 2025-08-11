require_relative '../domain/order/order_repository'
require_relative '../domain/order/order'
require_relative '../domain/order/order_item'
require_relative '../domain/order/price'
require_relative '../config/mongo_database'

class MongoOrderRepository < OrderDomain::OrderRepository
  def save(order)
    collection = DB[:orders]
    
    # Convert order to a hash
    order_data = {
      _id: order.id,
      items: order.items.map do |item|
        {
          product_id: item.product_id,
          quantity: item.quantity,
          price: item.price.amount
        }
      end
    }

    # Insert or update the order
    collection.insert_one(order_data, upsert: true)
  end

  def find_by_id(id)
    collection = DB[:orders]
    
    order_data = collection.find(_id: id).first
    return nil unless order_data

    order = OrderDomain::Order.new(order_data['_id'])
    order_data['items'].each do |item_data|
      item = OrderDomain::OrderItem.new(
        item_data['product_id'],
        item_data['quantity'],
        OrderDomain::Price.new(item_data['price'])
      )
      order.add_item(item)
    end

    order
  end
end
