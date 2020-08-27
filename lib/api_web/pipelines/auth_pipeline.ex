defmodule Api.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :api,
    module: Api.Guardian,
    error_handler: __MODULE__

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource

  @behaviour Guardian.Plug.ErrorHandler
  @impl Guardian.Plug.ErrorHandler
  @spec auth_error(Plug.Conn.t(), {any, any}, any) :: Plug.Conn.t()
  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{status: "failure", reason: to_string(type)})

    conn
    |> put_status(:unauthorized)
    |> put_resp_header("accepts", "application/json; charset=utf-8")
    |> send_resp(401, body)
  end
end
