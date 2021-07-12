class Product < ApplicationRecord
  belongs_to :shop
  
  mount_uploader :cover, CoverUploader
  
  acts_as_paranoid
end
