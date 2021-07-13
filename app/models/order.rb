class Order < ApplicationRecord
  belongs_to :shop
  belongs_to :product
end
