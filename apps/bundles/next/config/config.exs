# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

import_config "config.secret.exs"

# Configures the endpoint
config :next, NextWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QbAmUdYcDMMQ2e7wVp6PSXI8QdUjfDEGR0FTwjwkUIYS4lW1ledjE9Dkhr3pE4Qn",
  render_errors: [view: CoreWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Next.PubSub,
  live_view: [signing_salt: "U46ENwad8CDswjwuXgNZVpJjUlBjbmL9"],
  https: [port: 4001]

config :next, :children, [
  {SiteEncrypt.Phoenix, NextWeb.Endpoint},
  {Phoenix.PubSub, name: Next.PubSub}
]

config :next, ecto_repos: [Core.Repo]

config :core, :children, [
  Core.Repo,
  CoreWeb.Telemetry,
  {Phoenix.PubSub, name: Core.PubSub}
]

config :core, Core.Mailer, adapter: Bamboo.LocalAdapter
config :core, Core.SurfConext, []
config :core, SignInWithApple, []
config :core, GoogleSignIn, []

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :next, :ssl,
  client: :native,
  directory_url: {:internal, port: 4002},
  db_folder: Path.join("tmp", "site_encrypt_db"),
  domains: ["localhost"],
  emails: ["admin@localhost"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
