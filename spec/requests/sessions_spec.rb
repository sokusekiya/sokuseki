require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "GET /auth/github/callback" do
    let(:user) { create(:user) }
    let!(:authentication) { create(:authentication, user: user, uid: "12345") }

    context "登録済みのユーザーのとき" do
      before do
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          provider: "github",
          uid: "12345",
          info: {
            nickname: "yinm",
          },
        })
      end

      it "ユーザーを作らない" do
        expect { get "/auth/github/callback" }.not_to change(User, :count)
      end

      it "GitHubのusernameに変更がある場合は、変更に追従する" do
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          provider: "github",
          uid: "12345",
          info: {
            nickname: "yinm_updated",
          },
        })

        expect { get "/auth/github/callback" }.to change { authentication.reload.name }.from("yinm").to("yinm_updated")
      end

      it "root_pathにリダイレクトする" do
        get "/auth/github/callback"
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
