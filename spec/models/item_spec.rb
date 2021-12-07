require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できる場合' do
      it "全ての情報が正しく存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end
    context '商品出品できない場合' do
      it '商品画像がなければ出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空だと出品できない' do
        @item.item_name = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品の説明が空だと出品できない' do
        @item.describe = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Describe can't be blank")
      end
      it 'カテゴリーが初期状態（---)だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態が初期状態（---)だと出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it '配送料の負担が初期状態（---)だと出品できない' do
        @item.delivery_fee_load_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee load can't be blank")
      end
      it '発送元の地域が初期状態（---)だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数が初期状態（---)だと出品できない' do
        @item.sending_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sending date can't be blank")
      end
      it '販売価格が空だと出品できない' do
        @item.price = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が300円以下だと出品できない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '販売価格が9,999,999円以上だと出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it '販売価格が半角数値でないと出品できない' do
        @item.price = '６００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'userが紐づいていなければ出品できない' do
        @item.user = nil
        @item.valid?
        binding.pry
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
