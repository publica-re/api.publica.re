defmodule Api.Repo.Migrations.CreatePage do
  use Ecto.Migration

  def change do
    create table(:page) do
      add :tag, :string

      timestamps()
    end

  end
end
