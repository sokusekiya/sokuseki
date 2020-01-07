require "rails_helper"

RSpec.describe SharedLink, type: :model do
  let(:user) { create(:user) }
  before do
    @shared_link = SharedLink.new(token: SecureRandom.hex(32), expired_at: 30.minutes.after, on: "2019-12", user: user)
  end

  subject { @shared_link }

  describe "validation" do
    it { is_expected.to be_valid }
  end
end
