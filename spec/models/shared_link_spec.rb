require "rails_helper"

RSpec.describe SharedLink, type: :model do
  let(:user) { create(:user) }
  let(:token) { SecureRandom.hex(32) }
  let(:expired_at) { 30.minutes.after }
  let(:on) { "2019-12" }

  subject do
    SharedLink.new(token:, expired_at:, on:, user:)
  end

  describe "validation" do
    it { is_expected.to be_valid }

    context "on is nil" do
      let(:on) {
        nil
      }
      it { is_expected.to be_invalid }
    end

    context "on is too long" do
      let(:on) {
        SecureRandom.hex(512)
      }
      it { is_expected.to be_invalid }
    end
  end
end
