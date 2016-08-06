use Mix.Config

config :riak_core,
  node: 'dev_4@127.0.0.1',
  web_port: 8598,
  handoff_port: 8599,
  ring_state_dir: 'ring_data_dir_4',
  platform_data_dir: 'data_4'

config :erldocker,
  unixbridge_port: 42533,
  docker_http: "http://localhost:42533"

# config :lager,
#   error_logger_hwm: 5000,
#   handlers: [
#     lager_console_backend: :debug,
#   ]
