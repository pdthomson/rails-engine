require 'rails_helper'

RSpec.describe 'Items/Merchant API' do

  it "finds the merchants from an item" do
    create(:merchant)

    merchant1 = Merchant.first
    item = merchant1.items.first

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json_response = JSON.parse(response.body, symbolize_names: true)
    merchant = json_response[:data]

    expect(merchant).to be_a(Hash)
    expect(merchant[:attributes][:name]).to eq(merchant1.name)
    expect(merchant[:id]).to eq(("#{merchant1.id}"))
  end
end
