defmodule ApiWeb.PagesControllerTest do
  use ApiWeb.ConnCase

  alias Api.Projects
  alias Api.Projects.Pages

  @create_attrs %{
    tag: "some tag"
  }
  @update_attrs %{
    tag: "some updated tag"
  }
  @invalid_attrs %{tag: nil}

  def fixture(:pages) do
    {:ok, pages} = Projects.create_pages(@create_attrs)
    pages
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all page", %{conn: conn} do
      conn = get(conn, Routes.pages_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pages" do
    test "renders pages when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pages_path(conn, :create), pages: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.pages_path(conn, :show, id))

      assert %{
               "id" => id,
               "tag" => "some tag"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pages_path(conn, :create), pages: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pages" do
    setup [:create_pages]

    test "renders pages when data is valid", %{conn: conn, pages: %Pages{id: id} = pages} do
      conn = put(conn, Routes.pages_path(conn, :update, pages), pages: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.pages_path(conn, :show, id))

      assert %{
               "id" => id,
               "tag" => "some updated tag"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pages: pages} do
      conn = put(conn, Routes.pages_path(conn, :update, pages), pages: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pages" do
    setup [:create_pages]

    test "deletes chosen pages", %{conn: conn, pages: pages} do
      conn = delete(conn, Routes.pages_path(conn, :delete, pages))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.pages_path(conn, :show, pages))
      end
    end
  end

  defp create_pages(_) do
    pages = fixture(:pages)
    %{pages: pages}
  end
end
