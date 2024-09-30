class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  has_many :tags, dependent: :destroy
  has_one :sku, dependent: :destroy
  has_one :image, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
