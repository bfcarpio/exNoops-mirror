defmodule Exnoops.MixProject do
  use Mix.Project

  def project do
    [
      app: :exnoops,
      version: "0.1.2",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: [extras: ["README.md"]],
      description: description(),
      name: "exNoops",
      source_url: "https://gitlab.com/bfcarpio/exnoops",
      test_coverage: [summary: [threshold: 80]]
    ]
  end

  def description() do
    "Github's Noop API client for Elixir! Sample wrapping around the various Noop endpoints with minimal processing. Most processing converts dictionary objects to easier to parse tuples?"
  end

  def package do
    [
      name: :exnoops,
      maintainers: ["Brendan Carpio"],
      licenses: ["MIT"],
      docs: [extras: ["README.md"]],
      links: %{"Gitlab" => "https://gitlab.com/bfcarpio/exnoops"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:earmark, "~> 1.3.2", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:mojito, "~> 0.3.0"},
      {:json, "~> 1.3.0"},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
