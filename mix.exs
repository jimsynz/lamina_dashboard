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
      elixirc_paths: elixirc_paths(Mix.env()),
      docs: [
        main: "readme",
        extras: ["README.md", "CHANGELOG.md"]
      ]
    ]
  end

  def package do
    [
      maintainers: ["James Harton <james@harton.nz>"],
      licenses: ["HL3-FULL"],
      links: %{
        "Source" => "https://harton.dev/james/lamina_dashboard",
        "GitHub" => "https://github.com/jimsynz/lamina_dashboard",
        "Changelog" => "https://docs.harton.nz/james/lamina_dashboard/changelog.html",
        "Sponsor" => "https://github.com/sponsors/jimsynz"
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
      {:credo, "~> 1.6", only: ~w[dev test]a, runtime: false},
      {:dialyxir, "~> 1.4", only: ~w[dev test]a, runtime: false},
      {:doctor, "~> 0.22", only: ~w[dev test]a, runtime: false},
      {:ex_check, "~> 0.16", only: ~w[dev test]a, runtime: false},
      {:ex_doc, "~> 0.35", only: ~w[dev test]a, runtime: false},
      {:earmark, "~> 1.4", only: ~w[dev test]a, runtime: false},
      {:git_ops, "~> 2.4", only: ~w[dev test]a, runtime: false},
      {:jason, "~> 1.3", only: ~w[dev test]a},
      {:lamina, "~> 0.4"},
      {:phoenix_live_dashboard, "~> 0.7.0", optional: true},
      {:phoenix_live_reload, "~> 1.3", only: :dev}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
