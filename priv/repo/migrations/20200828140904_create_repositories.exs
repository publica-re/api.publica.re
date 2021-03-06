defmodule Api.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add :name, :string
      add :slug, :string
      add :physical, :string

      timestamps()
    end

  end
end
