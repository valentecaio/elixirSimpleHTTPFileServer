defmodule FileServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :file_server,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_options: [warnings_as_errors: false]
    ]
  end

  def application do
    [
      applications: [:logger, :iex, :inets, :cowboy, :plug_cowboy],
      mod: {FileServer.App, []}
    ]
  end

  defp deps do
    [
      {:mime, "~> 1.6.0"},
      {:cowboy, "~> 2.6.0"},
      {:plug_cowboy, "~> 2.0.0"},
    ]
  end
end
