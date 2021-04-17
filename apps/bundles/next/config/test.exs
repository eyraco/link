use Mix.Config

config :core, Core.Repo,
  username: System.get_env("POSTGRES_USER", "postgres"),
  password: System.get_env("POSTGRES_PASS", "postgres"),
  database: "next_test",
  hostname: System.get_env("POSTGRES_HOST", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox

config :core, Core.SurfConext, site: "https://connect.test.surfconext.nl"

config :next, NextWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Reduce password hashing impact on test duration
config :bcrypt_elixir,
  log_rounds: 4

config :core, GoogleSignIn,
  client_id: "client_id",
  client_secret: "client_secret",
  redirect_uri: "http://localhost:4000/google-sign-in/auth"

config :core, SignInWithApple,
  client_id: "client_id",
  team_id: "team_id",
  private_key_id: "key_id",
  private_key_path: "/full/key/path/private_key.p8",
  redirect_uri: "https://f14ca7e936dd.ngrok.io/apple/auth"
