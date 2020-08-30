defmodule Api.Projects.Pages do
  use Ecto.Schema
  import Ecto.Changeset

  schema "page" do
    field :tag, :string

    timestamps()
  end

  @doc false
  def changeset(pages, attrs) do
    pages
    |> cast(attrs, [:tag])
    |> validate_required([:tag])
  end
end
