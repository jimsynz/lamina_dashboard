defmodule Lamina.Dashboard.MixProject do
  use Mix.Project

  @version "1.0.0"
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
      licenses: ["HL3-FULL"],
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
      {:credo, "~> 1.6", only: ~w[dev test]a},
      {:ex_doc, ">= 0.28.1", only: ~w[dev test]a},
      {:git_ops, "~> 2.4", only: ~w[dev test]a, runtime: false},
      {:jason, "~> 1.3", only: ~w[dev test]a},
      {:lamina, "~> 0.4"},
      {:phoenix_live_dashboard, "~> 0.8.0", optional: true},
      {:phoenix_live_reload, "~> 1.3", only: :dev}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
