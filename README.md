# La Rocca

**Require Elixir 1.3 and Erlang 18.X not 19 !!!**

You can use [kerl][1] and [kiex][2] to set the correct version.

**La Rocca** is a pet project to explore the features of [riak_core][3] and [docker][4]. The idea is to use the multinode feature of riak_core to develop a simple cluster of running docker images. The idea is to be able to run containers and for example transfer some running containers from one node to another, do you know [Kubernetes][5] :wink:?

To launch it, always set a name of the node. For example:

`iex --sname s1 -S mix`

If you want run a a little _local_ cluster you can execute:

```sh
MIX_ENV=dev_1 iex --name dev_1@127.0.0.1 -S mix
MIX_ENV=dev_2 iex --name dev_2@127.0.0.1 -S mix
MIX_ENV=dev_3 iex --name dev_3@127.0.0.1 -S mix
```

and then join every node. Go to dev_1 console and join the dev_2 with `:riak_core.join('dev_2@127.0.0.1')` then go to dev_3 console and join one of the others with `:riak_core.join('dev_1@127.0.0.1')`. Check it with `:riak_core_status.ringready`.

The joining process is permanent so, if you stop and restart the nodes they will be join together.

If you want remove a node from a cluster, go to the console and execute `:riak_core.leave` after that the _handoff_ procedure start and at the end the node is shut down.

## Docker API

There are some docker libraries, the _official_ one is https://github.com/proger/erldocker as shown by docker [site][6]. This library is not published on [hex][7].

**Mix** is a great tool because we can use the git source directly :smile:.

On hex you can find some other  [libraries][8], [docker][9] and [ex_dockerapi][10] but they use only HTTP connection and require to change the docker configuration so I decide to [fork][11] the official.

## Notes

When we call `:riak_core_util.chash_key({"bucket-name", "key-name"})` we get a key of the object. If you want see in a readable form you can do something like this: `:riak_core_util.chash_key({"bucket-name", "key-name"}) |> Base.encode16`.

Every buckets has an associated function that used to calculate the hash of the pair bucket/key this function has one default that is `riak_core_util:chash_std_keyfun`. But when you configure the bucket you can change it.

The result is then passed to `riak_core_apl:get_primary_apl` to find the list of the **primary** physical node associated to this data.
This function receive 3 data:

```elixir
-spec get_primary_apl(binary(), n_val(), atom()) -> preflist_ann().
get_primary_apl(DocIdx, N, Service) ->
```

- `DocIdx`: is the id of the data to save obatined form `chash_key`.
- `N`: is how much data you want.
- `Service`: Is the type of service that you are searching.

First thing we need to create ping/pong service that you can try it  on shell executing `LaRocca.Service.ping`. In `LaRocca.Service` you can find some other services.

# Credits

Thanks to:
- [Marino Guerra][12] for his [book on riak core][13]
- [Ben Tyler][14] for his inspirational [talk][15]
- [Heinz N. Gies][16] for [riak_core_ng][17]
- [Ryan Zezeski][18] for the [try-try-try][19] blog

and last but not least thanks to [basho][20] for [riak_core][3].


[1]: https://github.com/kerl/kerl
[2]: https://github.com/taylor/kiex
[3]: https://github.com/basho/riak_core
[4]: https://github.com/taylor/kiex
[5]: http://kubernetes.io/
[6]: https://docs.docker.com/engine/reference/api/remote_api_client_libraries/
[7]: https://hex.pm/packages?search=erldocker&sort=downloads
[8]: https://hex.pm/packages?search=docker&sort=downloads
[9]: https://hex.pm/packages/docker
[10]: https://hex.pm/packages/ex_dockerapi
[11]: https://github.com/gpad/erldocker

[12]: http://marianoguerra.org/
[13]:http://marianoguerra.github.io/little-riak-core-book/index.html
[14]: https://github.com/kanatohodets
[15]: http://www.elixirconf.eu/elixirconf2016/ben-tyler
[16]: https://github.com/Licenser
[17]: https://hex.pm/packages/riak_core_ng
[18]: http://www.zinascii.com/
[19]: https://github.com/rzezeski/try-try-try
[20]: http://basho.com/
