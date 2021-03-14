class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = current_user.comments.new(comment_params)
    @comment.item_id = @item.id
    if @comment.save
      # 通知作成メソッドの呼び出し
      @item.create_notification_comment!(current_user, @comment.id)
    else
      render 'show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @item = @comment.item
    @comment.destroy
  end

  private
	def comment_params
		params.permit(:comment)
	end
end
