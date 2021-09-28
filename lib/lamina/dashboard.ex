defmodule Lamina.Dashboard do
  use Phoenix.LiveDashboard.PageBuilder
  alias Lamina.Dashboard.Remote
  alias Lamina.Registry.ServerRegistry
  alias Phoenix.LiveView.Socket

  @moduledoc """
  A LiveDashboard.PageBuilder which shows information about currently running
  Lamina configuration servers.

  ## Usage:

  Add the following to your LiveDashboard entry in your Phoenix router:

  ```elixir
  live_dashboard "/dashboard",
    additional_pages: [lamina: Lamina.Dashboard]
  ```
  """

  @doc false
  @impl true
  @spec mount(map, any, Socket.t()) :: {:ok, Socket.t()}
  def mount(params, _session, socket) do
    node = socket.assigns.page.node
    servers = Remote.list_servers(node)
    socket = assign(socket, servers: servers)
    nav = params["nav"]
    server = find_server(nav)
    first_server = hd(servers)

    cond do
      is_nil(server) && first_server ->
        to = live_dashboard_path(socket, socket.assigns.page, nav: server_id(first_server))
        {:ok, push_redirect(socket, to: to)}

      server ->
        config_keys = Remote.list_config_keys(node, server)
        providers = Remote.list_providers(node, server)

        {:ok, assign(socket, providers: providers, config_keys: config_keys, server: server)}

      true ->
        {:ok, socket}
    end
  end

  @doc false
  @impl true
  def menu_link(_, _), do: {:ok, "Lamina"}

  @doc false
  @impl true
  def render_page(%{servers: []} = assigns) do
    fn ->
      ~H"""
      No Lamina servers running on #{@page.node}.
      """
    end
  end

  def render_page(assigns) do
    items =
      for server <- assigns.servers do
        {server_id(server),
         name: inspect(server), render: render_server(assigns), method: :redirect}
      end

    nav_bar(items: items)
  end

  defp render_server(assigns) do
    fn ->
      table(
        columns: table_columns(),
        id: assigns.server,
        row_attrs: &row_attrs/1,
        row_fetcher: &fetch_table(assigns.server, &1, &2),
        title: "configuration settings"
      )
    end
  end

  defp server_id(server) when is_atom(server) do
    server
    |> Atom.to_string()
    |> Base.encode64(padding: false)
  end

  defp find_server(server_id) do
    ServerRegistry.all_servers()
    |> Enum.find(&(server_id(&1) == server_id))
  end

  defp table_columns,
    do: [
      %{
        field: :name,
        header: "Config key",
        header_attrs: [class: "p1-4"],
        cell_attrs: [class: "tabular-column-name p1-4"],
        sortable: :asc
      },
      %{
        field: :value,
        format: &format_value/1
      }
    ]

  defp format_value(value), do: inspect(value)

  defp row_attrs(_table), do: []

  defp fetch_table(server, params, node) do
    Remote.get_configs(node, server, params)
  end
end
