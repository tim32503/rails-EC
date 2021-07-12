class Shop < ApplicationRecord
  belongs_to :user
  has_many :products

  mount_uploader :cover, CoverUploader
end
