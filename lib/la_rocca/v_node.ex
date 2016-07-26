defmodule LaRocca.VNode do
  require Logger
  @behaviour :riak_core_vnode

  def start_vnode(partition) do
    :riak_core_vnode_master.get_vnode_pid(partition, __MODULE__)
  end

  def init([partition]) do
    {:ok, %{partition: partition}}
  end

  def handle_command(:ping, _sender, %{partition: partition} = state) do
    Logger.debug("GOT a ping request!")
    {:reply, {:pong, partition}, state}
  end

  def handle_command({:run_image, image, args}, _sender, state) do
    Logger.debug("GOT a run_image. state: #{inspect state}\nimage: #{inspect image}\nargs: #{inspect args}")

    {:ok, pid} = :docker_image.create(fromImage: image)
    read_stream_from(pid)

    Logger.debug("Image created!")

    {:reply, :ok, state}
  end

  defp read_stream_from(pid) do
    receive do
      {pid, {:data, :eof}} ->
        Logger.info("--- ALL DATA RECEIVED!!! ---")
      {pid, {:data, content}} ->
        Logger.info(content)
        read_stream_from(pid)
      {pid, error} ->
        Logger.error("ERROR from stream #{inspect error}")
    end
  end

  def handle_handoff_command(_fold_req, _sender, state) do
    {:noreply, state}
  end

  def handoff_starting(_target_node, state) do
    {true, state}
  end

  def handoff_cancelled(state) do
    {:ok, state}
  end

  def handoff_finished(_target_node, state) do
    {:ok, state}
  end

  def handle_handoff_data(data, state) do
    {:reply, :ok, state}
  end

  def encode_handoff_item(object_name, object_value) do
    ""
  end

  def is_empty(state) do
    {true, state}
  end

  def delete(state) do
    {:ok, state}
  end

  def handle_coverage(req, key_spaces, sender, state) do
    {:stop, :not_implemented, state}
  end

  def handle_exit(pid, reason, state) do
    {:noreply, state}
  end

  def terminate(reason, state) do
    :ok
  end
end
