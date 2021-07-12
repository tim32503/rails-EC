class Shop < ApplicationRecord
  belongs_to :user

  mount_uploader :cover, CoverUploader
end
