require_relative '../api/app'
require 'rack/test'
require 'rspec'
require 'json'
require_relative '../spec/spec_helper'
RSpec.describe 'Order API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'POST /orders' do
    it 'creates a new order' do
      order_data = {
        order_id: 'order_1',
        items: [
          { product_id: 'product_1', quantity: 2, price: { amount: 10.0 } },
          { product_id: 'product_2', quantity: 1, price: { amount: 20.0 } }
        ]
      }

      post '/orders', order_data.to_json, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eq(201)
      expect(JSON.parse(last_response.body)['order_id']).to eq('order_1')
    end

    it 'returns an error if order data is invalid' do
      post '/orders', {}.to_json, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eq(400)
      expect(JSON.parse(last_response.body)['error']).to eq('Invalid order data')
    end
  end

  describe 'GET /orders/:id' do
    it 'retrieves an existing order' do
      get '/orders/order_1'

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['order_id']).to eq('order_1')
    end

    it 'returns an error for a non-existing order' do
      get '/orders/non_existing_order'

      expect(last_response.status).to eq(404)
      expect(JSON.parse(last_response.body)['error']).to eq('Order not found')
    end
  end
end
