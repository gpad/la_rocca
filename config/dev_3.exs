use Mix.Config

config :riak_core,
  node: 'dev_3@127.0.0.1',
  web_port: 8398,
  handoff_port: 8399,
  ring_state_dir: 'ring_data_dir_3',
  platform_data_dir: 'data_3'

config :erldocker,
  unixbridge_port: 42333,
  docker_http: "http://localhost:42333"

# config :lager,
#   error_logger_hwm: 5000,
#   handlers: [
#     lager_console_backend: :debug,
#   ]
