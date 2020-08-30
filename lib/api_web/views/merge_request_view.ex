defmodule ApiWeb.MergeRequestView do
  use ApiWeb, :view
  alias ApiWeb.MergeRequestView

  def render("index.json", %{mergerequests: mergerequests}) do
    %{data: render_many(mergerequests, MergeRequestView, "merge_request.json")}
  end

  def render("show.json", %{merge_request: merge_request}) do
    %{data: render_one(merge_request, MergeRequestView, "merge_request.json")}
  end

  def render("merge_request.json", %{merge_request: merge_request}) do
    %{id: merge_request.id,
      remote_branch: merge_request.remote_branch,
      target_branch: merge_request.target_branch}
  end
end
