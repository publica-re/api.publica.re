defmodule ApiWeb.SessionController do
  use ApiWeb, :controller

  alias Api.Guardian

  alias Api.Accounts.User
  alias Api.Repo
  alias Api.Ldap

  def signin(conn, %{"username" => username, "password" => password}) do
    case Api.Ldap.authenticate(username, password) do
      :ok -> handle_sign_in(conn, username)
      {:error, message} -> handle_error(conn, message)
    end
  end

  defp handle_sign_in(conn, username) do
    {:ok, user} = insert_or_update_user(username)
    {:ok, token, claims} = Guardian.encode_and_sign(user)

    conn
    |> render("success.json", auth: %{jwt: token, claims: claims})
  end

  defp insert_or_update_user(username) do
    user_attributes = Ldap.get_by_uid(username)
    user = Repo.get_by(User, uid: username)

    changeset =
      case user do
        nil -> User.changeset(%User{}, user_attributes)
        _ -> User.changeset(user, user_attributes)
      end

    Repo.insert_or_update(changeset)
  end

  defp handle_error(conn, message) do
    conn
    |> put_status(:unauthorized)
    |> render("failure.json", reason: "unable to login " <> Atom.to_string(message))
  end

  def signout(conn, %{}) do
    conn
    |> Api.Guardian.Plug.sign_out()
    |> render("signout.json")
  end
end
