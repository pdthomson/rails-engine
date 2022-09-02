class Api::V1::Items::MerchantController < ApplicationController

  def index
    item = Item.find(params[:item_id])
    render json: MerchantSerializer.create_merchant(Merchant.find(item.merchant_id))
  end

end
