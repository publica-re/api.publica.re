# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api,
  ecto_repos: [Api.Repo],
  data_url: "/opt/publica.re/repos/",
  ldap_admin: %{user: [cn: "admin"], password: "2?_BL-R`eW%qj=>S"}
  password_secret:

# Configures the endpoint
config :api, ApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BEGibuLDjbNzvmvSrpbn4FxNMGZxe2DzZsGa18a6i8gv7sRKs6rDPOE+i1IAbdsW",
  render_errors: [view: ApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Api.PubSub,
  live_view: [signing_salt: "ZvLDGVSy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :paddle, Paddle,
  host: "publica.re",
  base: "dc=publica,dc=re",
  ssl: false,
  account_subdn: "ou=users",
  port: 389,
  schema_files: Path.wildcard("/etc/openldap/schema/*.schema")
