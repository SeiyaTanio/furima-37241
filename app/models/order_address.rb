class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :house_number, :building_name, :tel_number, :order_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipalities
    validates :house_number
    validates :tel_number, numericality: {only_integer: true}, format: {with: /\A\d{10,11}\z/}
    validates :token
    validates :order_id
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, house_number: house_number, building_name: building_name, tel_number: tel_number, order_id: order.id)
  end
end