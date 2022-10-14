require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '登録ができる時' do
      it '全ての項目の入力がが存在すれば登録できること' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上かつ半角英数字混合であれば登録できること' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
    end

    context '登録ができない時' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスが入力されていません。")
      end

      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスは既に使用されています。")
      end

      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードが入力されていません。", "もう一度パスワードを入力してくださいとパスワードの入力が一致しません")
      end

      it 'passwordが5文字以下であれば登録できないこと' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上に設定して下さい。")
      end

      it 'passwordが半角数字のみのときに登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは有効でありません。")
      end

      it 'passwordが半角英語のみのときに登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは有効でありません。")
      end

      it 'passwordが全角のときに登録できないこと' do
        @user.password = '１２３ABC'
        @user.password_confirmation = '１２３ABC'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは有効でありません。")
      end

      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '123abc'
        @user.password_confirmation = '1234ab'
        @user.valid?
        expect(@user.errors.full_messages).to include("もう一度パスワードを入力してくださいとパスワードの入力が一致しません")
      end
    end
  end
end
