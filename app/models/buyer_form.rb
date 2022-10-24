class BuyerForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :apartment, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :address
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid' }
    validates :token, presence: true
  end

  def save
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    Address.create(buyer_id: buyer.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, apartment: apartment, phone_number: phone_number)
  end
end
