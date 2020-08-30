defmodule ApiWeb.MergeRequestController do
  use ApiWeb, :controller

  alias Api.Projects
  alias Api.Projects.MergeRequest

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    mergerequests = Projects.list_mergerequests()
    render(conn, "index.json", mergerequests: mergerequests)
  end

  def create(conn, %{"merge_request" => merge_request_params}) do
    with {:ok, %MergeRequest{} = merge_request} <- Projects.create_merge_request(merge_request_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.merge_request_path(conn, :show, merge_request))
      |> render("show.json", merge_request: merge_request)
    end
  end

  def show(conn, %{"id" => id}) do
    merge_request = Projects.get_merge_request!(id)
    render(conn, "show.json", merge_request: merge_request)
  end

  def update(conn, %{"id" => id, "merge_request" => merge_request_params}) do
    merge_request = Projects.get_merge_request!(id)

    with {:ok, %MergeRequest{} = merge_request} <- Projects.update_merge_request(merge_request, merge_request_params) do
      render(conn, "show.json", merge_request: merge_request)
    end
  end

  def delete(conn, %{"id" => id}) do
    merge_request = Projects.get_merge_request!(id)

    with {:ok, %MergeRequest{}} <- Projects.delete_merge_request(merge_request) do
      send_resp(conn, :no_content, "")
    end
  end
end
