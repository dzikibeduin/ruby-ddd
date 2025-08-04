require 'sinatra'
require 'json'
require_relative '../application/place_order'
require_relative '../infrastructure/postgres_order_repository'

set :port, 4567

repo = PostgresOrderRepository.new
use_case = Application::PlaceOrder.new(repo)

post '/orders' do
  payload = JSON.parse(request.body.read, symbolize_names: true)

  order = use_case.call(payload[:order_id], payload[:items])
  content_type :json
  {
    order_id: order.id,
    total_price: order.total_price,
    items: order.items.map do |item|
      {
        product_id: item.product_id,
        quantity: item.quantity,
        price: item.price.amount
      }
    end
  }.to_json
end

get '/orders/' do
  content_type :json
  orders = repo.all.map do |order|
    {
      order_id: order.id,
      total_price: order.total_price,
      items: order.items.map do |item|
        {
          product_id: item.product_id,
          quantity: item.quantity,
          price: item.price.amount
        }
      end
    }
  end
  orders.to_json
end
