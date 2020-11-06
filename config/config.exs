# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :link,
  ecto_repos: [Link.Repo]

# Configures the endpoint
config :link, LinkWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QbAmUdYcDMMQ2e7wVp6PSXI8QdUjfDEGR0FTwjwkUIYS4lW1ledjE9Dkhr3pE4Qn",
  render_errors: [view: LinkWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Link.PubSub,
  live_view: [signing_salt: "Vp1B/xB7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :link, :pow,
  user: Link.Users.User,
  repo: Link.Repo,
  web_module: LinkWeb

# Registration of oauth providers is done in env specific config, here is an examle
# config :link, :pow_assent,
#   providers: [
#     google: [
#       client_id: "921548238010-bgv2ts6b3ih0q5d837nq4uh8rnrc3r6p.apps.googleusercontent.com",
#       client_secret: "SAEest9ls0F_WOsyL0w5ShLv",
#       strategy: Assent.Strategy.Google
#     ]
#   ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
