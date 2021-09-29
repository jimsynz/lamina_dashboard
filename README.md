# Lamina.Dashboard

`Lamina.Dashboard` is a tool to visualise the current runtime configuration of
the system.

It works as an additional page for [Phoenix LiveDashboard](https://hex.pm/packages/phoenix_live_dashboard).

## Installation

`Lamina.Dashboard` is [available in Hex](https://hex.pm/packages/lamina_dashboard),
the package can be installed by adding `lamina_dashboard` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:lamina_dashboard, "~> 0.2.2"}
  ]
end
```

Documentation for the latest release can be found on [HexDocs](https://hexdocs.pm/lamina) and for the `main` branch [here](https://jimsy.gitlab.io/lamina_dashboard/api-reference.html).

## Integration with LiveDashboard

You can add this page to your Phoenix LiveDashboard by adding it as a page in the `live_dashboard` macro in your router file:

```elixir
  live_dashboard "/dashboard",
    additional_pages: [lamina: Lamina.Dashboard]
```

Once configured, you will be able to access `Lamina.Dashboard` at `/dashboard/lamina`.

## Distribution

You can use `Lamina.Dashboard` to view the configuration on remote nodes by simply adding the `lamina_dashboard` package as a dependency of your remote nodes.
