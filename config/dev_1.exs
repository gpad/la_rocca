use Mix.Config

config :riak_core,
  node: 'dev_1@127.0.0.1',
  web_port: 8198,
  handoff_port: 8199,
  ring_state_dir: 'ring_data_dir_1',
  platform_data_dir: 'data_1'

config :erldocker,
  unixbridge_port: 42133,
  docker_http: "http://localhost:42133"
