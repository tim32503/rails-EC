class Shop < ApplicationRecord
  belongs_to :user
  has_many :products
  has_many :orders

  mount_uploader :cover, CoverUploader
end
