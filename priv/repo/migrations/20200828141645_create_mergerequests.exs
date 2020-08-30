defmodule Api.Repo.Migrations.CreateMergerequests do
  use Ecto.Migration

  def change do
    create table(:mergerequests) do
      add :remote_branch, :string
      add :target_branch, :string

      timestamps()
    end

  end
end
