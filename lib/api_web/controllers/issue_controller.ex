defmodule ApiWeb.IssueController do
  use ApiWeb, :controller

  alias Api.Projects
  alias Api.Projects.Issue

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    issues = Projects.list_issues()
    render(conn, "index.json", issues: issues)
  end

  def create(conn, %{"issue" => issue_params}) do
    with {:ok, %Issue{} = issue} <- Projects.create_issue(issue_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.issue_path(conn, :show, issue))
      |> render("show.json", issue: issue)
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Projects.get_issue!(id)
    render(conn, "show.json", issue: issue)
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    issue = Projects.get_issue!(id)

    with {:ok, %Issue{} = issue} <- Projects.update_issue(issue, issue_params) do
      render(conn, "show.json", issue: issue)
    end
  end

  def delete(conn, %{"id" => id}) do
    issue = Projects.get_issue!(id)

    with {:ok, %Issue{}} <- Projects.delete_issue(issue) do
      send_resp(conn, :no_content, "")
    end
  end
end
