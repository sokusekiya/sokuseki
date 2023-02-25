require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "GET /auth/github/callback" do
    context "登録済みのユーザーのとき" do
      let(:user) { create(:user) }
      let!(:authentication) { create(:authentication, user:, uid: "12345") }

      before do
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          provider: "github",
          uid: "12345",
          info: {
            nickname: "yinm",
          },
          credentials: {
            token: "abcde12345",
          },
        })
      end

      it "ユーザーを作らない" do
        expect { get "/auth/github/callback" }.not_to change(User, :count)
      end

      it "GitHubのusernameに変更がない場合は、更新処理を行わない" do
        expect { get "/auth/github/callback" }.not_to change { authentication.reload.updated_at }
      end

      it "GitHubのusernameに変更がある場合は、変更に追従する" do
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          provider: "github",
          uid: "12345",
          info: {
            nickname: "yinm_updated",
          },
          credentials: {
            token: "abcde12345",
          },
        })

        expect { get "/auth/github/callback" }.to change { authentication.reload.name }.from("yinm").to("yinm_updated")
      end

      it "root_pathにリダイレクトする" do
        get "/auth/github/callback"
        expect(response).to redirect_to(root_path)
      end
    end

    context "未登録のユーザーのとき" do
      before do
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          provider: "github",
          uid: "99999",
          info: {
            nickname: "new user",
            image: "https://example.com/avatar.png",
          },
          credentials: {
            token: "abcd1234",
          },
        })
      end

      it "ユーザーを作る" do
        expect { get "/auth/github/callback" }.to change(User, :count).by(1)
      end

      it "root_pathにリダイレクトする" do
        get "/auth/github/callback"
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
