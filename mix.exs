defmodule LaRocca.Mixfile do
  use Mix.Project

  def project do
    [app: :la_rocca,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:riak_core, :logger, :erldocker],
     mod: {LaRocca, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:riak_core, "~> 2.2.6", hex: :riak_core_ng},
      {:lager, "3.0.2", [env: :prod, hex: :lager, manager: :rebar, override: true]},
      {:erldocker, git: "https://github.com/gpad/erldocker.git"}
    ]
  end
end
