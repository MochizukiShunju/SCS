class SearchsController < ApplicationController
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @datas = partical(@model, @content).order("#{sort_column} #{sort_direction}").page(params[:page]).per(5)
  end

  private

  # 部分一致検索
  def partical(model, content)
    if model == 'user'
      User.where("name LIKE ?", "%#{content}%")
      .or(User.where("department LIKE ?", "%#{content}%"))
      .or(User.where("user_code LIKE ?", "%#{content}%"))
    elsif model == 'item'
      Item.where("name LIKE ?", "%#{content}%")
      .or(Item.where("model LIKE ?", "%#{content}%"))
      .or(Item.where("retailer LIKE ?", "%#{content}%"))
      .or(Item.where("maker LIKE ?", "%#{content}%"))
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
end
