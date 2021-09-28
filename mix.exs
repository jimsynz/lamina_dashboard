defmodule Lamina.Dashboard.MixProject do
  use Mix.Project

  @version "0.2.1"
  @description "A Phoenix LiveDashboard page for inspecting your Lamina configurations"

  def project do
    [
      app: :lamina_dashboard,
      version: @version,
      description: @description,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def package do
    [
      maintainers: ["James Harton <james@harton.nz>"],
      licenses: ["Hippocratic"],
      links: %{
        "Source" => "https://gitlab.com/jimsy/lamina_dashboard"
      }
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
      {:credo, "~> 1.5", only: ~w[dev test]a},
      {:ex_doc, ">= 0.0.0", only: ~w[dev test]a},
      {:git_ops, "~> 2.3", only: ~w[dev test]a, runtime: false},
      {:jason, "~> 1.0", only: ~w[dev test]a},
      {:lamina, "~> 0.4"},
      {:phoenix_live_dashboard, "~> 0.5.1", optional: true},
      {:phoenix_live_reload, "~> 1.2", only: :dev}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
