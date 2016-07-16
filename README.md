# La Rocca

**Require Elixir 1.3 and Erlang 18.X not 19 !!!**

You need to launch it always on a node with a name. For example:

`iex --sname s1 -S mix`

# A little cluster

```
MIX_ENV=dev_1 iex --name dev_1@127.0.0.1 -S mix
MIX_ENV=dev_2 iex --name dev_2@127.0.0.1 -S mix
MIX_ENV=dev_3 iex --name dev_3@127.0.0.1 -S mix
```

and then join in, go to dev_1 console and join the dev_2 with `:riak_core.join('dev_2@127.0.0.1')` then go to dev_3 console and join one of the others with `:riak_core.join('dev_1@127.0.0.1')`.

The joining process is permanent so, if you stop and restart the nodes they will be join together.

## Notes

When we call `:riak_core_util.chash_key({"bucket-name", "key-name"})` we get a key of the object. If you want see in a readable form you can do something like this: `:riak_core_util.chash_key({"bucket-name", "key-name"}) |> Base.encode16`.

Every buckets has an associated function that used to calculate the hash of the pair bucket/key this function has one default that is `riak_core_util:chash_std_keyfun`. But when you configure the bucket you can change it.

The result is the passed to `riak_core_apl:get_primary_apl` to find the list of the **primary** physical node associated to this data.
This function receive 3 data:

```
-spec get_primary_apl(binary(), n_val(), atom()) -> preflist_ann().
get_primary_apl(DocIdx, N, Service) ->
```

- `DocIdx`: is the id of the data to save obatined form `chash_key`.
- `N`: is how much data you want.
- `Service`: Is the type of service that you are searching.

We can use service to find for example the node that mange network, storage or something like this. We can start service at runtime using the configuration.

First thing we need to create ping/pong service.

http://marianoguerra.github.io/little-riak-core-book/how-a-command-works.html


In the application we need to start supervisor, if supervisor start ok we need to register our vnode and then our service.



## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `la_rocca` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:la_rocca, "~> 0.1.0"}]
    end
    ```

  2. Ensure `la_rocca` is started before your application:

    ```elixir
    def application do
      [applications: [:la_rocca]]
    end
    ```
