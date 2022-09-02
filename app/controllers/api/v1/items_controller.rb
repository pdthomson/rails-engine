
class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.create_items(Item.all)
  end

  def show
    render json: ItemSerializer.create_item(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.create_item(item), status: 201
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  def update
    item = Item.find(params[:id])
    item.update!(item_params)
    render json: ItemSerializer.create_item(item), status: 200
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
