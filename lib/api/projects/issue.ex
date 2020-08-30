defmodule Api.Projects.Issue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "issues" do
    field :content, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(issue, attrs) do
    issue
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
