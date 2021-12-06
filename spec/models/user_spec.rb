require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "全ての情報が正しく存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'kanji_family_nameが空では登録できない' do
        @user.kanji_family_name = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji family name can't be blank")
      end
      it 'kanji_first_nameが空では登録できない' do
        @user.kanji_first_name = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji first name can't be blank")
      end
      it 'kana_family_nameが空では登録できない' do
        @user.kana_family_name = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana family name can't be blank")
      end
      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name can't be blank")
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      it '既に登録されているemailでは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailに@が含まれないと登録できない' do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが５文字以下では登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordに英数字以外の文字が入っていると登録できない' do
        @user.password = '123ab-'
        @user.password_confirmation = '123ab-'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '123abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'kanji_family_nameに漢字・かな・カタカナ以外の文字が入っていると登録できない' do
        @user.kanji_family_name = '田中a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji family name is invalid. Input full-width characters")
      end
      it 'kanji_first_nameに漢字・かな・カタカナ以外の文字が入っていると登録できない' do
        @user.kanji_first_name = '太郎a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji first name is invalid. Input full-width characters")
      end
      it 'kana_family_nameにカタカナ以外の文字が入っていると登録できない' do
        @user.kana_family_name = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana family name is invalid. Input full-width katakana characters")
      end
      it 'kana_first_nameにカタカナ以外の文字が入っていると登録できない' do
        @user.kana_first_name = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name is invalid. Input full-width katakana characters")
      end
    end
  end
end
