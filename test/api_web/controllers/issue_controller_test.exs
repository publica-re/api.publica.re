defmodule ApiWeb.IssueControllerTest do
  use ApiWeb.ConnCase

  alias Api.Projects
  alias Api.Projects.Issue

  @create_attrs %{
    content: "some content",
    title: "some title"
  }
  @update_attrs %{
    content: "some updated content",
    title: "some updated title"
  }
  @invalid_attrs %{content: nil, title: nil}

  def fixture(:issue) do
    {:ok, issue} = Projects.create_issue(@create_attrs)
    issue
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all issues", %{conn: conn} do
      conn = get(conn, Routes.issue_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create issue" do
    test "renders issue when data is valid", %{conn: conn} do
      conn = post(conn, Routes.issue_path(conn, :create), issue: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.issue_path(conn, :show, id))

      assert %{
               "id" => id,
               "content" => "some content",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.issue_path(conn, :create), issue: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update issue" do
    setup [:create_issue]

    test "renders issue when data is valid", %{conn: conn, issue: %Issue{id: id} = issue} do
      conn = put(conn, Routes.issue_path(conn, :update, issue), issue: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.issue_path(conn, :show, id))

      assert %{
               "id" => id,
               "content" => "some updated content",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, issue: issue} do
      conn = put(conn, Routes.issue_path(conn, :update, issue), issue: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete issue" do
    setup [:create_issue]

    test "deletes chosen issue", %{conn: conn, issue: issue} do
      conn = delete(conn, Routes.issue_path(conn, :delete, issue))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.issue_path(conn, :show, issue))
      end
    end
  end

  defp create_issue(_) do
    issue = fixture(:issue)
    %{issue: issue}
  end
end
