class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.create_merchants(Merchant.all)
  end

  def show
    render json: MerchantSerializer.create_merchant(Merchant.find(params[:id]))
  end
end
