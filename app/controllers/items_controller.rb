class ItemsController < ApplicationController
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    # 名前順に並び替え
    @items = Item.order(:name).order("#{sort_column} #{sort_direction}").page(params[:page]).per(5)
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
    if @item.save
      redirect_to items_path
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      # Item0個の時、通知作成メソッドの呼び出し
      if @item.amount == 0
         @item.update_notification_item!(current_user, @item.id)
      elsif @item.amount > 0
         @item.update_notification_item!(current_user, @item.id)
      end
      redirect_to items_path
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :model, :amount, :price, :retailer, :status, :item_image, :maker, :position)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

end
