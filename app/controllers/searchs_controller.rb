class SearchsController < ApplicationController
  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @content)
  end

  private
  def match(model, content)
    if model == 'user'
       User.where(name: content)
       .or(User.where(group: content))
       .or(User.where(user_code: content))

    elsif model == 'item'
      Item.where(name: content)
      .or(Item.where(model: content))
      .or(Item.where(retailer: content))
      .or(Item.where(maker: content))
    end
  end

  def forward(model, content)
    if model == 'user'
      User.where("name LIKE ?", "#{content}%")
      .or(User.where("group LIKE ?", "#{content}%"))
      .or(User.where("user_code LIKE ?", "#{content}%"))

    elsif model == 'item'
      Item.where("name LIKE ?", "#{content}%")
      .or(Item.where("model LIKE ?", "#{content}%"))
      .or(Item.where("retailer LIKE ?", "#{content}%"))
      .or(Item.where("maker LIKE ?", "#{content}%"))
    end
  end

  def backward(model, content)
    if model == 'user'
      User.where("name LIKE ?", "%#{content}")
      .or(User.where("group LIKE ?", "#{content}%"))
      .or(User.where("user_code LIKE ?", "#{content}%"))

    elsif model == 'item'
      Item.where("name LIKE ?", "%#{content}")
      .or(Item.where("model LIKE ?", "#{content}%"))
      .or(Item.where("retailer LIKE ?", "#{content}%"))
      .or(Item.where("maker LIKE ?", "#{content}%"))
    end
  end

  def partical(model, content)
    if model == 'user'
      User.where("name LIKE ?", "%#{content}%")
      .or(User.where("group LIKE ?", "#{content}%"))
      .or(User.where("user_code LIKE ?", "#{content}%"))
    elsif model == 'item'
      Item.where("name LIKE ?", "%#{content}%")
      .or(Item.where("model LIKE ?", "#{content}%"))
      .or(Item.where("retailer LIKE ?", "#{content}%"))
      .or(Item.where("maker LIKE ?", "#{content}%"))
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
end
