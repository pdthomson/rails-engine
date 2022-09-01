class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: ItemSerializer.create_items(merchant.items)
  end

end
