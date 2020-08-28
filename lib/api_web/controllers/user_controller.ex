defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  defp renew_token(conn) do
    current = Api.Guardian.Plug.current_token(conn)
    {:ok, _old, {token, claims}} = Api.Guardian.refresh(current)
    Api.Guardian.revoke(current)
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

  def delete(conn, %{}) do
    current = Api.Guardian.Plug.current_token(conn)
    {:ok, user, _claims} = Api.Guardian.resource_from_token(current)

    Api.Accounts.delete_user(user)

    conn
    |> render("success.json", %{})
  end

  def create(conn, params) do
    if Map.has_key?(params, "uid") and Map.has_key?(params, "sn") and
         Map.has_key?(params, "userPassword") do
      {status, _user} = Paddle.get(filter: [uid: params["uid"]], base: [ou: "users"])

      if status != :ok do
        case Api.Accounts.create_user(Api.Ldap.from_object(params)) do
          :ok ->
            ApiWeb.SessionController.signin(conn, %{
              "username" => params["uid"],
              "password" => params["userPassword"]
            })

          {:error, :missing_unique_identifier} ->
            render(conn, "failure.json",
              reason: "missing unique identifier",
              auth: renew_token(conn)
            )

          {:error, :missing_required_attributes, fields} ->
            render(conn, "failure.json",
              reason:
                "missing required attribute: " <>
                  Enum.join(Enum.map(fields, fn x -> Atom.to_string(x) end), " and "),
              auth: renew_token(conn)
            )

          {:error, error} ->
            render(conn, "failure.json", reason: error, auth: renew_token(conn))
        end
      else
        conn
        |> render("failure.json", reason: "user already exists", auth: renew_token(conn))
      end
    else
      conn
      |> render("failure.json", reason: "missing uid or userPassword", auth: renew_token(conn))
    end
  end
end
