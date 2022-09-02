require 'rails_helper'

RSpec.describe 'Find all items API' do

  it "can find all items by name" do
    create(:merchant)
    merchant = Merchant.create!(name: "The Founder")
    Item.create!(name: 'Mac', description: 'Paper weight', unit_price: 225.00, merchant_id: merchant.id)
    Item.create!(name: 'Macaroni', description: 'Paper weight', unit_price: 225.00, merchant_id: merchant.id)
    Item.create!(name: 'Apple Watch', description: 'Paper weight', unit_price: 225.00, merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=Mac"
# binding.pry
    expect(response).to be_successful
    expect(response.status).to eq(200)

    json_response = JSON.parse(response.body, symbolize_names: true)
    items = json_response[:data]
# binding.pry
    expect(items).to be_a(Array)
    expect(items.count).to eq(2)

    items.each do |item|
      expect(item[:attributes][:name]).to_not eq("Apple Watch")
    end
  end

  it "returns items that cost more than the search" do
    merchant = Merchant.create!(name: "The Founder")
    Item.create!(name: 'Mac', description: 'Paper weight', unit_price: 225.00, merchant_id: merchant.id)
    Item.create!(name: 'Macaroni', description: 'Paper weight', unit_price: 99.00, merchant_id: merchant.id)
    Item.create!(name: 'Apple Watch', description: 'Paper weight', unit_price: 225.00, merchant_id: merchant.id)

    get "/api/v1/items/find_all?min_price=100"

    json_response = JSON.parse(response.body, symbolize_names: true)
    items = json_response[:data]

    expect(items).to be_a(Array)
    expect(items.count).to eq(2)

    items.each do |item|
      expect(item[:attributes][:name]).to_not eq("Macaroni")
    end
  end

  it "can return items less than the search" do
    merchant = Merchant.create!(name: "The Founder")
    Item.create!(name: 'Mac', description: 'Paper weight', unit_price: 89.00, merchant_id: merchant.id)
    Item.create!(name: 'Macaroni', description: 'Paper weight', unit_price: 99.99, merchant_id: merchant.id)
    Item.create!(name: 'Apple Watch', description: 'Paper weight', unit_price: 225.00, merchant_id: merchant.id)

    get "/api/v1/items/find_all?max_price=100"

    json_response = JSON.parse(response.body, symbolize_names: true)
    items = json_response[:data]

    expect(items).to be_a(Array)
    expect(items.count).to eq(2)

    items.each do |item|
      expect(item[:attributes][:name]).to_not eq("Apple Watch")
    end
  end
end
