defmodule ApiWeb.RepositoryView do
  use ApiWeb, :view
  alias ApiWeb.RepositoryView

  def render("index.json", %{repositories: repositories}) do
    %{data: render_many(repositories, RepositoryView, "repository.json")}
  end

  def render("show.json", %{repository: repository}) do
    %{data: render_one(repository, RepositoryView, "repository.json")}
  end

  def render("repository.json", %{repository: repository}) do
    %{id: repository.id,
      name: repository.name,
      slug: repository.slug,
      physical: repository.physical}
  end
end
