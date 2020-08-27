defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  defp renew_token(conn) do
    current = Api.Guardian.Plug.current_token(conn)
    {:ok, _old, {token, claims}} = Api.Guardian.refresh(current)
    %{jwt: token, claims: claims}
  end

  def index(conn, _params) do
    users = Api.Accounts.list_users()
    render(conn, "index.json", users: users, auth: renew_token(conn))
  end

  def show(conn, %{"id" => username}) do
    current = Api.Guardian.Plug.current_token(conn)

    if username == "-" do
      {:ok, user, _claims} = Api.Guardian.resource_from_token(current)
      render(conn, "show.json", user: user, auth: renew_token(conn))
    else
      user = Api.Accounts.get_user!(username)
      render(conn, "show.json", user: user, auth: renew_token(conn))
    end
  end
end
