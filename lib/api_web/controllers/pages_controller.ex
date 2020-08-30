defmodule ApiWeb.PagesController do
  use ApiWeb, :controller

  alias Api.Projects
  alias Api.Projects.Pages

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    page = Projects.list_page()
    render(conn, "index.json", page: page)
  end

  def create(conn, %{"pages" => pages_params}) do
    with {:ok, %Pages{} = pages} <- Projects.create_pages(pages_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.pages_path(conn, :show, pages))
      |> render("show.json", pages: pages)
    end
  end

  def show(conn, %{"id" => id}) do
    pages = Projects.get_pages!(id)
    render(conn, "show.json", pages: pages)
  end

  def update(conn, %{"id" => id, "pages" => pages_params}) do
    pages = Projects.get_pages!(id)

    with {:ok, %Pages{} = pages} <- Projects.update_pages(pages, pages_params) do
      render(conn, "show.json", pages: pages)
    end
  end

  def delete(conn, %{"id" => id}) do
    pages = Projects.get_pages!(id)

    with {:ok, %Pages{}} <- Projects.delete_pages(pages) do
      send_resp(conn, :no_content, "")
    end
  end
end
