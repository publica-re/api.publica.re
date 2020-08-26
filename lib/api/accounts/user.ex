defmodule Api.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :photo, :binary
    field :givenName, :string
    field :surname, :string
    field :displayName, :string
    field :email, :string
    field :phone, :string
    field :url, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :photo, :givenName, :surname, :displayName, :email, :phone, :url])
    |> validate_required([:username, :displayName, :email])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  def login_changeset do
    %__MODULE__{} |> cast(%{}, ~w(username password), ~w())
  end

end
