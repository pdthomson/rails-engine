require 'rails_helper'

RSpec.describe 'Merchant find API' do

  it "can find a merchant by name" do
    create(:merchant)
    Merchant.create!(name: "Hell's Dump Truck")
    Merchant.create!(name: "Hell's Hole")

    get "/api/v1/merchants/find?name=Hell"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json_response = JSON.parse(response.body, symbolize_names: true)
    merchant = json_response[:data]

    expect(merchant).to be_a(Hash)
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant).to have_key(:id)
    expect(merchant).to have_key(:type)

    expect(merchant[:type]).to be_a(String)
    expect(merchant[:id]).to be_a(String)
    expect(merchant[:attributes][:name]).to be_a(String)
    expect(merchant[:attributes][:name]).to eq("Hell's Dump Truck")
    expect(merchant[:attributes][:name]).to_not eq("Hell's Hole")
  end

  it "will return an empty object if there is no match" do

    get '/api/v1/merchants/find?name=ring'
    json_response = JSON.parse(response.body, symbolize_names: true)

  end

end
