# Lamina.Dashboard

[![Build Status](https://drone.harton.dev/api/badges/james/lamina_dashboard/status.svg?ref=refs/heads/main)](https://drone.harton.dev/james/lamina_dashboard)
[![Hex.pm](https://img.shields.io/hexpm/v/lamina_dashboard.svg)](https://hex.pm/packages/lamina_dashboard)
[![Hippocratic License HL3-FULL](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-FULL&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/full.html)

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
    {:lamina_dashboard, "~> 1.0.0"}
  ]
end
```

Documentation for the latest release can be found on [HexDocs](https://hexdocs.pm/lamina).

## Integration with LiveDashboard

You can add this page to your Phoenix LiveDashboard by adding it as a page in the `live_dashboard` macro in your router file:

```elixir
  live_dashboard "/dashboard",
    additional_pages: [lamina: Lamina.Dashboard]
```

Once configured, you will be able to access `Lamina.Dashboard` at `/dashboard/lamina`.

## Distribution

You can use `Lamina.Dashboard` to view the configuration on remote nodes by simply adding the `lamina_dashboard` package as a dependency of your remote nodes.

## Github Mirror

This repository is mirrored [on Github](https://github.com/jimsynz/lamina_dashboard)
from it's primary location [on my Forejo instance](https://harton.dev/james/lamina_dashboard).
Feel free to raise issues and open PRs on Github.

## License

This software is licensed under the terms of the
[HL3-FULL](https://firstdonoharm.dev), see the `LICENSE.md` file included with
this package for the terms.

This license actively proscribes this software being used by and for some
industries, countries and activities. If your usage of this software doesn't
comply with the terms of this license, then [contact me](mailto:james@harton.nz)
with the details of your use-case to organise the purchase of a license - the
cost of which may include a donation to a suitable charity or NGO.
