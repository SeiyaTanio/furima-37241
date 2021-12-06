class Item < ApplicationRecord

  with_options presence: true do
    validates :item_name
    validates :describe
    validates :price
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :status_id
      validates :delivery_fee_load_id
      validates :prefecture_id
      validates :sending_date_id
    end
  end

  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :satatus
  belongs_to :delivery_fee_load
  belongs_to :prefecture
  belongs_to :sending_date
end
