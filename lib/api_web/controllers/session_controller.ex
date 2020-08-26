defmodule ApiWeb.SessionController do
  use ApiWeb, :controller

  alias Api.Guardian

  def signin(conn, %{"user" => params}) do
    username = params["username"]
    password = params["password"]
    conn
  end

  def signout(conn, params) do
    Guardian.Plug.sign_out(conn, params)
    |> redirect(to: "/api/v1")
  end
end
