require 'rails_helper'

RSpec.describe 'Items API' do

  xit "creates a list of a items" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/items"
  end
end
