require 'rails_helper'

RSpec.describe 'Items API' do

  it "creates a list of a items" do
    create(:merchant)

    get "/api/v1/items"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json_response = JSON.parse(response.body, symbolize_names: true)
    items = json_response[:data]

    expect(items).to be_a(Array)
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to be_a(Hash)
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes].keys).to eq([:name, :description, :unit_price, :merchant_id])

      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end
end
