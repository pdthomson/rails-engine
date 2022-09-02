require 'rails_helper'

RSpec.describe 'Item API' do

  it "can retrieve and item by the items id" do
    create(:merchant)

    item1_id = Item.first.id
    item2_id = Item.second.id

    get "/api/v1/items/#{item1_id}"

    json_response = JSON.parse(response.body, symbolize_names: true)
    item = json_response[:data]

    expect(item).to be_a(Hash)
    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)
    expect(item[:id]).to_not eq(item2_id)

    expect(item[:attributes]).to be_a(Hash)
    expect(item[:attributes].keys).to eq([:name, :description, :unit_price, :merchant_id])

    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end

  it "can create a new item" do
    create(:merchant)

    merchant_id = Merchant.first.id

    item_params = ({
      name: 'ruby',
      description: 'a glamourous crystal',
      unit_price: 150.00,
      merchant_id: merchant_id
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      json_response = JSON.parse(response.body, symbolize_names: true)
      item = json_response[:data]

      new_item = Item.last

      expect(new_item.name).to eq(item_params[:name])
      expect(new_item.description).to eq(item_params[:description])
      expect(new_item.unit_price).to eq(item_params[:unit_price])
      expect(new_item.merchant_id).to eq(item_params[:merchant_id])

      expect(item[:attributes][:name]).to eq(item_params[:name])
      expect(item[:attributes][:description]).to eq(item_params[:description])
      expect(item[:attributes][:unit_price]).to eq(item_params[:unit_price])
      expect(item[:attributes][:merchant_id]).to eq(item_params[:merchant_id])
  end

  it "can delete an item" do
    create(:merchant)

    item1 = Item.first
    merchant = Merchant.first

    expect(merchant.items.count).to eq(3)

    delete "/api/v1/items/#{item1.id}"

    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(merchant.items.count).to eq(2)
  end

  it "can update an item" do
    create(:merchant)
    item = Item.first

    item_params = {
      name: 'The count of Monte Cristo'
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

    updated_item = Item.first

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(updated_item.name).to eq('The count of Monte Cristo')
    expect(updated_item.description).to eq(item.description)
  end

end
