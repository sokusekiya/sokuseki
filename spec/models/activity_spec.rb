require "rails_helper"

RSpec.describe Activity, type: :model do
  describe ".issue_and_pr" do
    let(:user) { create(:user) }
    let(:authentication) { create(:authentication, user:) }
    let!(:issue_event) { create(:activity, :issue_event, user:, authentication:) }
    let!(:pull_request_event) { create(:activity, :pull_request_event, user:, authentication:) }
    let!(:commit_comment_event) { create(:activity, :commit_comment_event, user:, authentication:) }

    it "IssuesEvent, PullRequestEventだけを取得する" do
      expect(Activity.issue_and_pr).to contain_exactly(issue_event, pull_request_event)
    end
  end
end
