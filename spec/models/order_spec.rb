require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { User.create(name: 'Bob Loblaws', email: 'bob@loblaws.com') }
  let(:address) do
    Address.create(user_id: user.id,
                   address1: '432 Park Ave',
                   address2: 'PH 9901', city: 'New York',
                   zipcode: '10025',
                   state: 'NY')
  end
  let(:order) do
    Order.create(number: 'M11582',
                 state: 'crunk',
                 total: 100.83,
                 user_id: user.id,
                 address_id: address.id)
  end

  describe '#self.search(search)' do
    it 'returns search results by user email' do
      search = { user_email: order.user.email }
      order
      expect(Order.search(search).first.id).to eq(order.id)
    end

    it 'returns search results by user name' do
      search = { user_name: order.user.name }

      expect(Order.search(search).first.id).to eq(order.id)
    end

    it 'returns orders with a by state' do
      search = { user_state: order.state }
      expect(Order.search(search).first.state).to eq(order.state)
    end

    it 'returns nil if nothing is found' do
      search = { user_name: 'North West' }
      expect(Order.search(search).empty?).to eq(true)
    end

    it 'if no search paramters present return all orders' do
      expect(Order.search({}).count).to eq(Order.all.count)
    end
  end
end
