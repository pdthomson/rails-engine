require 'rails_helper'

RSpec.describe 'Merchants API' do

  it "creates a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    json_response = JSON.parse(response.body, symbolize_names: true)
    merchants = json_response[:data]

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)
    end
  end

end
