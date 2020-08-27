defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  def index(conn, _params) do
    current = Api.Guardian.Plug.current_token(conn)
    {:ok, _old, {token, claims}} = Api.Guardian.refresh(current)
    users = Api.Accounts.list_users()
    render(conn, "index.json", users: users, jwt: token, claims: claims)
  end

  def show(conn, %{"id" => username}) do
    user = Api.Accounts.get_user!(username)
    render(conn, "show.json", user: user)
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{}) do
    current = Api.Guardian.Plug.current_token(conn)
    user = Api.Guardian.resource_from_token(current)
    render(conn, "show.json", user: user)
  end
end
