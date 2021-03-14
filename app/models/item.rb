class Item < ApplicationRecord
  attachment :item_image

	has_many :comments, dependent: :destroy
	has_many :bookmarks, dependent: :destroy
	has_many :notifications, dependent: :destroy
	def bookmarked_by?(user)
	  bookmarks.where(user_id: user.id).exists?
	end

	validates :name, presence: true
	validates :model, presence: true
	validates :amount, presence: true
	validates :price, presence: true
	validates :retailer, presence: true
	validates :maker, presence: true

  def create_notification_comment!(current_user, comment_id)
		# 自分以外にコメントしている人をすべて取得し、全員に通知を送る
		temp_ids = User.where.not(id: current_user.id)
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['id'])
    end

    temp_comment_ids = Comment.select(:user_id).where(item_id: id).where.not(user_id: current_user.id).distinct

    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, current_user.id) if temp_comment_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      item_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # item0個場合
  def update_notification_item!(current_user, item_id)
    users = User.where.not(id: current_user.id)
    users.each do |user|
      notification = current_user.active_notifications.new(
      item_id: item_id,
      visited_id: user.id,
      action: 'quantity'
      )
    notification.save if notification.valid?
    end
  end
end
