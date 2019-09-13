module ActivitiesHelper
  def markdown_list(activities)
    activities.reject { |activity|
      activity.activity_type == "IssuesEvent" && activity.original_data["action"] != "opened"
    }.map { |activity|
      data = activity.original_data
      target = (activity.activity_type == "IssuesEvent") ? data["issue"] : data["pull_request"]

      "- [%<title>s](%<url>s)" % { title: target["title"], url: target["html_url"] }
    }.uniq.join("\n")
  end

  def markdown_list_group_by_repository(activities)
    activities.reject { |activity|
      activity.activity_type == "IssuesEvent" && activity.original_data["action"] != "opened"
    }.reject { |activity|
      activity.repo_name.nil?
    }.group_by(&:repo_name).map { |repo_name, repo_activities|
      list =
        repo_activities.map { |activity|
          data = activity.original_data
          target = (activity.activity_type == "IssuesEvent") ? data["issue"] : data["pull_request"]

          "- [%<title>s](%<url>s)" % { title: target["title"], url: target["html_url"] }
        }.uniq.join("\n")

      "### #{repo_name}\n\n#{list}\n"
    }.join("\n")
  end
end
