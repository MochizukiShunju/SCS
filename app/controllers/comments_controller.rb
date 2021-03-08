class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
		@comment = Comment.new(comment_params)
		@comment.item_id = @item.id
		@comment.user_id = current_user.id
		@comment.save
    redirect_to item_path(@item.id)
  end

  def destroy
    @item = Item.find(params[:item_id])
  	@comment = @item.comments.find(params[:id])
		@comment.destroy
		redirect_to item_path(@item.id)
  end

  private
	def comment_params
		params.permit(:comment)
	end
end
