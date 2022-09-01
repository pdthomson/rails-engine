class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.create_merchants(Merchant.all)
  end
end
