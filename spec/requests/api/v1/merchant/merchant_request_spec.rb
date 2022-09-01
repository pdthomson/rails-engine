require 'rails_helper'

RSpec.describe 'Merchants api' do

  it "finds a merchant by id" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    get "/api/v1/merchants/#{merchant1.id}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json_response = JSON.parse(response.body, symbolize_names: true)
    merchant = json_response[:data]

    expect(merchant).to be_a(Hash)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_an(String)

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)
    expect(merchant[:id]).to eq("#{merchant1.id}")
    expect(merchant[:id]).to_not eq("#{merchant2.id}")
  end

end
