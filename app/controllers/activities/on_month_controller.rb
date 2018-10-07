class Activities::OnMonthController < ApplicationController
  before_action :redirect_to_root_unless_signed_in

  def index
    @month_string = params[:month_string]
    @activities = current_user.activities.on(@month_string)

    @markdown_content = @activities.issue_and_pr.order(:acted_at).reject { |activity|
      activity.activity_type == "IssuesEvent" && activity.original_data["action"] != "opened"
    }.map { |activity|
      data = activity.original_data
      target = activity.activity_type == 'IssuesEvent' ? data["issue"] : data["pull_request"]
      "- [%s](%s)" % [target["title"], target["html_url"]]
    }.join("\n")
  end
end
