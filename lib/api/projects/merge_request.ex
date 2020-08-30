defmodule Api.Projects.MergeRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mergerequests" do
    field :remote_branch, :string
    field :target_branch, :string

    timestamps()
  end

  @doc false
  def changeset(merge_request, attrs) do
    merge_request
    |> cast(attrs, [:remote_branch, :target_branch])
    |> validate_required([:remote_branch, :target_branch])
  end
end
