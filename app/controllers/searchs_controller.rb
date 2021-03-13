class SearchsController < ApplicationController

  helper_method :sort_column, :sort_direction

  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @content).order("#{sort_column} #{sort_direction}")
  end

  private

  # 完全一致検索
  def match(model, content)
    if model == 'user'
       User.where(name: content)
       .or(User.where(department: content))
       .or(User.where(user_code: content))

    elsif model == 'item'
      Item.where(name: content)
      .or(Item.where(model: content))
      .or(Item.where(retailer: content))
      .or(Item.where(maker: content))
    end
  end

  # 前方一致検索
  def forward(model, content)
    if model == 'user'
      User.where("name LIKE ?", "#{content}%")
      .or(User.where("department LIKE ?", "#{content}%"))
      .or(User.where("user_code LIKE ?", "#{content}%"))
    elsif model == 'item'
      Item.where("name LIKE ?", "#{content}%")
      .or(Item.where("model LIKE ?", "#{content}%"))
      .or(Item.where("retailer LIKE ?", "#{content}%"))
      .or(Item.where("maker LIKE ?", "#{content}%"))
    end
  end

  # 後方一致検索
  def backward(model, content)
    if model == 'user'
      User.where("name LIKE ?", "%#{content}")
      .or(User.where("department LIKE ?", "%#{content}"))
      .or(User.where("user_code LIKE ?", "%#{content}"))
    elsif model == 'item'
      Item.where("name LIKE ?", "%#{content}")
      .or(Item.where("model LIKE ?", "%#{content}"))
      .or(Item.where("retailer LIKE ?", "%#{content}"))
      .or(Item.where("maker LIKE ?", "%#{content}"))
    end
  end

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

  def search_for(how, model, content)
    case how
    when 'match'
      match(model, content)
    when 'forward'
      forward(model, content)
    when 'backward'
      backward(model, content)
    when 'partical'
      partical(model, content)
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
end
