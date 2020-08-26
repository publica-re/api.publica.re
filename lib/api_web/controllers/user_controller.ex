defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  def index(conn, _params) do
    users = Api.Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => username}) do
    user = Api.Accounts.get_user!(username)
    render(conn, "show.json", user: user)
  end
end
