defmodule GsisOauth.MixProject do
  use Mix.Project

  def project do
    [
      app: :gsis_oauth,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :oauth2]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:oauth2, "~> 2.0"}, {:jason, "~> 1.2"}, {:sweet_xml, "~> 0.6.5"}]
  end
end
