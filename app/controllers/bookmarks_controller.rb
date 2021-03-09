class BookmarksController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @bookmark = current_user.bookmarks.new(item_id: @item.id)
    @bookmark.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    @bookmark = current_user.bookmarks.find_by(item_id: @item.id)
    @bookmark.destroy
  end
end
