defmodule LaRocca.Service do
  require IEx

  def ping do
    doc_idx = :riak_core_util.chash_key({"ping", bin_timestamp})
    pref_list = :riak_core_apl.get_primary_apl(doc_idx, 1, LaRocca.Service)

    [{index_node, _type}] = pref_list

    # riak core appends "_master" to VNode.
    :riak_core_vnode_master.sync_spawn_command(index_node, :ping, LaRocca.VNode_master)
  end

  def run(image) do
    docIdx = :riak_core_util.chash_key({image, bin_timestamp})
    [idxNode] = :riak_core_apl.get_apl(docIdx, 1, LaRocca.Service)
    # :riak_core_vnode_master.command(idxNode, {:run_image, image, ""}, LaRocca.VNode_master)
    :riak_core_vnode_master.sync_spawn_command(idxNode, {:run_image, image, ""}, LaRocca.VNode_master)
  end

  def bin_timestamp do
    :erlang.term_to_binary(:os.timestamp())
  end

end
