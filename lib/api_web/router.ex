defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Api.Guardian.AuthPipeline
  end

  # unauthenticated
  scope "/api/v1", ApiWeb do
    pipe_through :api

    post "/sign/in", SessionController, :signin
    post "/users", UserController, :create
  end

  # authenticated
  scope "/api/v1", ApiWeb do
    pipe_through [:api, :authenticated]

    get "/sign/out", SessionController, :signout
    resources "/users", UserController, except: [:create]
    resources "/repositories/", UserController, except: [:create]
    resources "/repositories/:owner/:id/issues", UserController, except: [:create]
    resources "/repositories/:owner/:id/merge", UserController, except: [:create]
  end

  pipeline :git do
    plug :set_git_options, binary: "/bin/sh"
  end

  scope "/" do
    pipe_through :git

    match :*, "/git/*git_path", PhoenixCGI,
      args: ["-c", "/usr/lib/git-core/git-http-backend"],
      path_info: {:param, "git_path"},
      extra_env: %{
        GIT_PROJECT_ROOT: "/home/dvbmgr/Téléchargements/o/api.git",
        GIT_HTTP_EXPORT_ALL: "1"
      }

    get "/cgi/env.json", PhoenixCGI,
      binary: "/usr/bin/elixir",
      args: ["/home/dvbmgr/phoenix_cgi/test/scripts/script.ex"]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
    end
  end

  defp set_git_options(conn, binary: binary) do
    assign(conn, :binary, binary)
  end
end
