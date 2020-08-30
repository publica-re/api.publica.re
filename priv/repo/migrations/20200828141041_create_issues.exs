defmodule Api.Repo.Migrations.CreateIssues do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :title, :string
      add :content, :string

      timestamps()
    end

  end
end
