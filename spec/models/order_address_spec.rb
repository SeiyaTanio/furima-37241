require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address ,user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it "全ての情報が正しく存在すれば登録できる" do
        expect(@order_address).to be_valid
      end
    end
    context '商品出品できない場合' do
      it '郵便番号がなければ出品できない' do
        @order_address.postal_code = ' '
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が3桁ハイフン4桁でなければ出品できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号が半角文字列でなければ出品できない' do
        @order_address.postal_code = '１２３−４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '都道府県が初期状態（---)だと出品できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村がなければ出品できない' do
        @order_address.municipalities = ' '
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipalities can't be blank")
      end
      it '番地がなければ出品できない' do
        @order_address.house_number = ' '
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号がなければ出品できない' do
        @order_address.tel_number = ' '
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel number can't be blank")
      end
      it '電話番号が半角数字でなければ出品できない' do
        @order_address.tel_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel number is not a number")
      end
      it '電話番号が半角数字の10文字以上11文字以下でなければ出品できない' do
        @order_address.tel_number = '1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel number is invalid")
      end
      it '電話番号が半角数字の12文字以上の場合は出品できない' do
        @order_address.tel_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel number is invalid")
      end
      it 'token（クレジットカード情報）がなければ出品できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idがなければ出品できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idがなければ出品できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
