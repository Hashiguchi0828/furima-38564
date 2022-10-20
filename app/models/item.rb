class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shipping_date
  belongs_to :status
  has_one_attached :image

  validates :name, :description, :category_id, :status_id, :postage_id, :shipping_date_id, :price, :prefecture_id, :image, presence: true
  validates :category_id, :postage_id, :prefecture_id, :shipping_date_id, :status_id, numericality: { other_than: 0, message: "can't be blank" } 
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
