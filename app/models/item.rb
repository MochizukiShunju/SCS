class Item < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
	has_many :comments, dependent: :destroy
  attachment :item_image
end
