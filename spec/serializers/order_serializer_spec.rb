# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::OrderSerializer do # rubocop:disable Metrics/BlockLength
  subject { serializer.as_json }

  let(:company)   { Company.new(id: '1', name: 'company_name', address: 'address_text') }
  let(:customer)  { Customer.new(id: '1', first_name: 'first-name', last_name: 'last_name') }
  let(:product1) { Product.new('1', '12345') }
  let(:product2) { Product.new('2', '67890') }
  let(:products) { [product1, product2] }
  let(:order) do 
    Order.new(id: '1', status: 'not_confirmed', value: 100.0, delivery_time: Time.current, 
              notes: nil, customer: customer, company: company, products: products)
  end 
  let(:serializer) { described_class.new(order) }

  it 'allows attributes to be defined for serialization' do
    expect(subject.keys).to contain_exactly(
      *%w[
        id
        status
        value
        delivery_time
        notes
        created_at
        updated_at
        company
        customer
        products
      ]
    )
  end

  describe 'relationships' do
    it 'returns single company' do
      data = Api::V1::CompanySerializer.new(order.company).as_json.deep_stringify_keys
      expect(subject['company']).to eq(data)
    end

    it 'returns single customer' do
      data = Api::V1::CustomerSerializer.new(order.customer).as_json
      expect(subject['customer']).to eq(data)
    end

    it 'returns array of products' do
      data = order.products.map { Api::V1::ProductSerializer.new(_1).as_json }
      expect(subject['products']).to contain_exactly(*data)
    end
  end

  describe 'notes' do
    it 'is nil if an empty string' do
      order.notes = ''
      expect(subject['notes']).to eq(nil)
    end
  end

  describe '#as_json' do
    it 'returns correct payload' do
      expect(subject.except('customer', 'company', 'products')).to eq(
        'id' => order.id,
        'status' => 'not_confirmed',
        'value' => 100.00,
        'delivery_time' => order.delivery_time.iso8601,
        'notes' => nil,
        'created_at' => order.created_at.iso8601,
        'updated_at' => order.updated_at.iso8601
      )
    end
  end
end
