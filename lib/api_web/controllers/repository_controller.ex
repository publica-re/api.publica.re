defmodule ApiWeb.RepositoryController do
  use ApiWeb, :controller

  alias Api.Projects
  alias Api.Projects.Repository

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    repositories = Projects.list_repositories()
    render(conn, "index.json", repositories: repositories)
  end

  def create(conn, %{"repository" => repository_params}) do
    with {:ok, %Repository{} = repository} <- Projects.create_repository(repository_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.repository_path(conn, :show, repository))
      |> render("show.json", repository: repository)
    end
  end

  def show(conn, %{"id" => id}) do
    repository = Projects.get_repository!(id)
    render(conn, "show.json", repository: repository)
  end

  def update(conn, %{"id" => id, "repository" => repository_params}) do
    repository = Projects.get_repository!(id)

    with {:ok, %Repository{} = repository} <- Projects.update_repository(repository, repository_params) do
      render(conn, "show.json", repository: repository)
    end
  end

  def delete(conn, %{"id" => id}) do
    repository = Projects.get_repository!(id)

    with {:ok, %Repository{}} <- Projects.delete_repository(repository) do
      send_resp(conn, :no_content, "")
    end
  end
end
