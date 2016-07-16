defmodule LaRocca.PingService do

  def ping do
    doc_idx = :riak_core_util.chash_key({"ping", :erlang.term_to_binary(:os.timestamp())})
    pref_list = :riak_core_apl.get_primary_apl(doc_idx, 1, LaRocca.PingService)

    [{index_node, _type}] = pref_list

    # riak core appends "_master" to VNode.
    :riak_core_vnode_master.sync_spawn_command(index_node, :ping, LaRocca.VNode_master)
  end

end
