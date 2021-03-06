defmodule GreenLight.MixProject do
  use Mix.Project

  def project do
    [
      app: :green_light,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: [],
      deps: deps(),
      # The main page in the docs
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ]
      ],
      dialyzer: [
        plt_add_deps: :transitive
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.5"},
      {:phoenix_live_view, "~> 0.15.1"},
      {:phoenix_ecto, "~> 4.1"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      # Dev and test deps
      {:ex_doc, "~> 0.22", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.5.0-rc.2", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
