defmodule ApiWeb.IssueView do
  use ApiWeb, :view
  alias ApiWeb.IssueView

  def render("index.json", %{issues: issues}) do
    %{data: render_many(issues, IssueView, "issue.json")}
  end

  def render("show.json", %{issue: issue}) do
    %{data: render_one(issue, IssueView, "issue.json")}
  end

  def render("issue.json", %{issue: issue}) do
    %{id: issue.id,
      title: issue.title,
      content: issue.content}
  end
end
