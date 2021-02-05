require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { FactoryBot.create(:user) }
    let!(:post) { build(:post, user_id: user.id)}

    subject { test_post.valid? }
    let(:test_post) { post }

    context 'titleカラム' do
      it '空欄でないこと' do
        test_post.title = ''
        is_expected.to eq false;
      end

      it '２文字以上８０字以内であること' do
        post.title = Faker::Lorem.characters(number:1)
        post.title = Faker::Lorem.characters(number:81)
        expect(post.valid?).to eq false;
      end
    end

    context 'contentカラム' do
      it '空欄でないこと' do
        test_post.content = ''
        is_expected.to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1である' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end