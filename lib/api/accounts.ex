defmodule Api.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo
  alias Api.Accounts.User
  alias Api.Ldap

  alias Api.Accounts.User

  def list_users, do: Repo.all(User)

  def get_user!(id), do: Repo.get_by!(User, uid: id)

  def create_user(user) do
    Api.Ldap.add_object(user)
  end

  def update_user(user, attrs) do
    Paddle.modify(user, {:replace, attrs})
  end

  def delete_user(user) do
    Repo.delete(user)
    Api.Ldap.delete_by_uid(user.uid)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
