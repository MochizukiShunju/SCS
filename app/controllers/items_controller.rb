class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to items_path
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      # Item0個の時、通知作成メソッドの呼び出し
      if @item.amount == 0
         @item.update_notification_item!(current_user, @item.id)
      end
    end
    redirect_to items_path
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :model, :amount, :price, :retailer, :status, :item_image, :maker)
  end
end
