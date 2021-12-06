class Item < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :satatus
  belongs_to :delivery_fee_load
  belongs_to :prefecture
  belongs_to :sending_date
end
