defmodule Lamina.Dashboard.Remote do
  alias Lamina.Registry.ServerRegistry
  alias Lamina.Server

  @moduledoc """
  Uses the Erlang `:rpc` module to interact with potentially-remote Lamina
  servers.
  """

  @doc """
  List the running configuration servers on the remote node.
  """
  @spec list_servers(node) :: [module]
  def list_servers(node) do
    :rpc.call(node, __MODULE__, :do_list_servers, [])
  rescue
    _ -> []
  end

  @doc """
  List the configuration keys for a specific server on the remote node.
  """
  @spec list_config_keys(node, module) :: [atom]
  def list_config_keys(node, server) do
    :rpc.call(node, __MODULE__, :do_list_config_keys, [server])
  end

  @doc """
  List the configured providers for server on node.
  """
  @spec list_providers(node, module) :: [{module, keyword}]
  def list_providers(node, server) do
    :rpc.call(node, __MODULE__, :do_list_providers, [server])
  end

  @doc """
  Retrieve all configuration values from a remote server.
  """
  @spec get_configs(node, module, map) :: [map]
  def get_configs(node, server, params) do
    :rpc.call(node, __MODULE__, :do_get_configs, [server, params])
  end

  @doc false
  @spec do_list_servers :: [module]
  def do_list_servers do
    if function_exported?(ServerRegistry, :all_servers, 0) do
      ServerRegistry.all_servers()
      |> Enum.sort()
    else
      []
    end
  end

  @doc false
  @spec do_list_config_keys(module) :: [atom]
  def do_list_config_keys(server) do
    server.__lamina__.(:config_keys)
  end

  @doc false
  @spec do_list_providers(module) :: [{module, keyword}]
  def do_list_providers(server) do
    server.__lamina__.(:providers)
  end

  @doc false
  @spec do_get_configs(module, map) :: {[map], non_neg_integer()}
  def do_get_configs(server, params) do
    sort_dir = if params.sort_dir == :asc, do: &<=/2, else: &>=/2

    all_rows =
      server
      |> apply(:__lamina__, [:config_keys])
      |> Enum.map(fn config_key ->
        %{
          name: config_key,
          value: Server.get!(server, config_key)
        }
      end)

    rows =
      all_rows
      |> maybe_filter_rows(params.search)
      |> Enum.sort_by(&Map.get(&1, params.sort_by), sort_dir)
      |> Enum.take(params.limit)

    {rows, length(all_rows)}
  end

  defp maybe_filter_rows(rows, nil), do: rows

  defp maybe_filter_rows(rows, search_term) do
    Stream.filter(rows, fn row ->
      row
      |> Map.values()
      |> Enum.any?(fn value ->
        value
        |> inspect()
        |> String.downcase()
        |> String.contains?(search_term)
      end)
    end)
  end
end
