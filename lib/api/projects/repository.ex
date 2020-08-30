defmodule Api.Projects.Repository do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repositories" do
    field :name, :string
    field :slug, :string
    field :physical, :string
    belongs_to :owner, Api.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:name, :slug, :physical])
    |> validate_required([:name, :slug, :physical])
  end
end
