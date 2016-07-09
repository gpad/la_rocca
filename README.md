# LaRocca

**Require Elixir 1.3 and Erlang 18.X not 19 !!!**

You need to launch it always on a node with a name. For example:

`iex --sname s1 -S mix`

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
