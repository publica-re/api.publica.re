defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Api.Guardian.AuthPipeline
  end

  scope "/api/v1", ApiWeb do
    pipe_through :api

    post "/sign/in", SessionController, :signin
  end

  scope "/api/v1", ApiWeb do
    pipe_through [:api, :authenticated]

    resources "/users", UserController, only: [:index]
    resources "/user", UserController, only: [:show]
    get "/sign/out", SessionController, :signout
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
    end
  end
end
