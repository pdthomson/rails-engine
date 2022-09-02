class Api::V1::Items::FindController < ApplicationController

  def index
    # binding.pry
    if params[:min_price] && params[:max_price] && params[:name]
      render json: { message: "Try again punk"}
    elsif (params[:min_price] || params[:max_price]) && params[:name]
      render json: { message: "I said good day"}
    elsif params[:max_price] && params[:min_price]
      items = Item.min_price_search(params[:min_price])
      range = items.max_price_search(params[:max_price])
      render json: ItemSerializer.create_items(range)
    else
      items = Item.name_search(params[:name]) if params[:name]
      items = Item.min_price_search(params[:min_price]) if params[:min_price]
      items = Item.max_price_search(params[:max_price]) if params[:max_price]
      render json: ItemSerializer.create_items(items)
    end
  end
end
