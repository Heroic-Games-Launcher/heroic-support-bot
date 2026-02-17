defmodule HeroicSupport.MixProject do
  use Mix.Project

  def project do
    [
      app: :heroic_support,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: System.fetch_env!("MIX_ENV") == "prod",
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HeroicSupport.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    # [{:nostrum, "~> 0.10"}]
    # Or, for bleeding edge changes:
    [{:nostrum, github: "Kraigie/nostrum"}, {:req, "~> 0.5.0"}]
  end
end
