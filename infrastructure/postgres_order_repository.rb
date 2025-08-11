require_relative '../domain/order/order_repository'
require_relative '../domain/order/order'
require_relative '../domain/order/order_item'
require_relative '../domain/order/price'
require_relative '../config/database'

class PostgresOrderRepository < OrderDomain::OrderRepository
  def save(order)
    DB.transaction do
      order_table = DB[:orders]
      items_table = DB[:order_items]

      orders_table.insert(external_id: order.id)

      order.items.each do |item|
        items_table.insert(
          order_id: orders_table.where(external_id: order.id).get(:id),
          product_id: item.product_id,
          quantity: item.quantity,
          price: item.price.amount
        )
      end
    end
  end

  def find_by_id(id)
    order_table = DB[:orders]
    items_table = DB[:order_items]

    order_row = orders_table.where(external_id: id).first
    return nil unless order_row

    order = OrderDomain::Order.new(id)
    items_table.where(order_id: order_row[:id]).each do |item_row|
      item = OrderDomain::OrderItem.new(
        item_row[:product_id],
        item_row[:quantity],
        item_row[:price]
      )
      order.add_item(item)
    end

    order
  end

  def all
    orders_table = DB[:orders]
    items_table = DB[:order_items]

    orders_table.all.map do |order_row|
      order = OrderDomain::Order.new(order_row[:external_id])
      items_table.where(order_id: order_row[:id]).each do |item_row|
        order.add_item(OrderDomain::OrderItem.new(item_row[:product_id], item_row[:quantity], item_row[:price]))
      end
    end
  end
end
