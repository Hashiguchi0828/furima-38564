class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category

  validates :name, :description, :category_id, :status_id, :postage_id, :shipping_date_id, :price, :prefecture_id, :image, presence: true
  validates :category_id, numericality: { other_than: 0, message: "can't be blank" } 
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
