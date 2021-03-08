class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to items_path
  end

  def update
  end

  def deatroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :model, :amount, :price, :retailer, :status, :item_image)
  end
end
