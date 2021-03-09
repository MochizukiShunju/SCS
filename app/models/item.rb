class Item < ApplicationRecord
  attachment :item_image

	has_many :comments, dependent: :destroy
	has_many :bookmarks, dependent: :destroy
	def bookmarked_by?(user)
	  bookmarks.where(user_id: user.id).exists?
	end
end
