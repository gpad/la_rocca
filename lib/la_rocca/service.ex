defmodule LaRocca.Service do
  require IEx
  require Logger

  def ping do
    doc_idx = :riak_core_util.chash_key({"ping", bin_timestamp})
    pref_list = :riak_core_apl.get_primary_apl(doc_idx, 1, LaRocca.Service)

    [{index_node, _type}] = pref_list

    # riak core appends "_master" to VNode.
    :riak_core_vnode_master.sync_spawn_command(index_node, :ping, LaRocca.VNode_master)
  end

  def run(image) do
    doc_idx = :riak_core_util.chash_key({"image", image})
    pref_list = :riak_core_apl.get_apl(doc_idx, 3, LaRocca.Service)
    Logger.debug("Executing command on:\n#{inspect pref_list} ... ")
    ret = :riak_core_vnode_master.command(pref_list, {:run_image, image, ""}, LaRocca.VNode_master)

    #TODO -> Execute

    # We need to find Pid instead of node ... make some test

    # command2([{Index, Pid}|Rest], Msg, Sender, VMaster, How=normal)
    #   when is_pid(Pid) ->
    #     gen_fsm:send_event(Pid, make_request(Msg, Sender, Index)),
    #     command2(Rest, Msg, Sender, VMaster, How);



    Logger.debug("Command return: '#{inspect ret}'.")
  end

  def bin_timestamp do
    :erlang.term_to_binary(:os.timestamp())
  end

end
