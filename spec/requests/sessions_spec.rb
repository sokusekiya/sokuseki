require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /auth/github/callback' do
    let(:user) { create(:user) }
    let!(:authentication) { create(:authentication, user: user, uid: '12345') }

    context '登録済みのユーザーのとき' do
      it 'ユーザーを作らない' do
        expect{get '/auth/github/callback'}.not_to change(User, :count)
      end

      it 'root_pathにリダイレクトする' do
        get '/auth/github/callback'
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
