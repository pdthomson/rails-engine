class Api::V1::Merchants::FindController < ApplicationController

  def show
    merchant = Merchant.search(params[:name]).first
    if merchant.nil?
      render json: MerchantSerializer.no_merchant
    else
      render json: MerchantSerializer.create_merchant(merchant)
    end
  end

end
