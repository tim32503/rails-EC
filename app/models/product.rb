class Product < ApplicationRecord
  belongs_to :shop
  has_many :orders
  
  mount_uploader :cover, CoverUploader
  
  acts_as_paranoid
end
