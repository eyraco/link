defmodule Core.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Core.Repo,
      CoreWeb.Telemetry,
      {SiteEncrypt.Phoenix, CoreWeb.Endpoint},
      {Phoenix.PubSub, name: Core.PubSub},
      {Oban, oban_config()}
    ]

    opts = [strategy: :one_for_one, name: Core.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(_changed, _new, _removed) do
    :ok
  end

  defp oban_config do
    Application.fetch_env!(:core, Oban)
  end
end
