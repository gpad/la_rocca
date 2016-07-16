defmodule LaRocca do
  use Application
  require Logger

  def start(_type, _args) do

    case LaRocca.Supervisor.start_link do
      {:ok, pid} ->
        :ok = :riak_core.register(vnode_module: LaRocca.VNode)
        :ok = :riak_core_node_watcher.service_up(LaRocca.PingService, self())
        {:ok, pid}
      {:error, reason} ->
        Logger.error("Unable to start La Rocca supervisor because: #{inspect reason}")
    end

  end
end
