defmodule ApiWeb.MergeRequestControllerTest do
  use ApiWeb.ConnCase

  alias Api.Projects
  alias Api.Projects.MergeRequest

  @create_attrs %{
    remote_branch: "some remote_branch",
    target_branch: "some target_branch"
  }
  @update_attrs %{
    remote_branch: "some updated remote_branch",
    target_branch: "some updated target_branch"
  }
  @invalid_attrs %{remote_branch: nil, target_branch: nil}

  def fixture(:merge_request) do
    {:ok, merge_request} = Projects.create_merge_request(@create_attrs)
    merge_request
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all mergerequests", %{conn: conn} do
      conn = get(conn, Routes.merge_request_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create merge_request" do
    test "renders merge_request when data is valid", %{conn: conn} do
      conn = post(conn, Routes.merge_request_path(conn, :create), merge_request: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.merge_request_path(conn, :show, id))

      assert %{
               "id" => id,
               "remote_branch" => "some remote_branch",
               "target_branch" => "some target_branch"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.merge_request_path(conn, :create), merge_request: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update merge_request" do
    setup [:create_merge_request]

    test "renders merge_request when data is valid", %{conn: conn, merge_request: %MergeRequest{id: id} = merge_request} do
      conn = put(conn, Routes.merge_request_path(conn, :update, merge_request), merge_request: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.merge_request_path(conn, :show, id))

      assert %{
               "id" => id,
               "remote_branch" => "some updated remote_branch",
               "target_branch" => "some updated target_branch"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, merge_request: merge_request} do
      conn = put(conn, Routes.merge_request_path(conn, :update, merge_request), merge_request: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete merge_request" do
    setup [:create_merge_request]

    test "deletes chosen merge_request", %{conn: conn, merge_request: merge_request} do
      conn = delete(conn, Routes.merge_request_path(conn, :delete, merge_request))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.merge_request_path(conn, :show, merge_request))
      end
    end
  end

  defp create_merge_request(_) do
    merge_request = fixture(:merge_request)
    %{merge_request: merge_request}
  end
end
