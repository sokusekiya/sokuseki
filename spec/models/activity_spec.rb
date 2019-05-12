require "rails_helper"

RSpec.describe Activity, type: :model do
  describe ".issue_and_pr" do
    let!(:issue_event) { FactoryBot.create(:activity, :issue_event) }
    let!(:pull_request_event) { FactoryBot.create(:activity, :pull_request_event) }
    let!(:commit_comment_event) { FactoryBot.create(:activity, :commit_comment_event) }

    it "IssuesEvent, PullRequestEventだけを取得する" do
      expect(Activity.issue_and_pr).to contain_exactly(issue_event, pull_request_event)
    end
  end
end
