use Mix.Config

# Enable debug log on console
config :lager,
  handlers: [
    lager_console_backend: :debug,
  ]

config :riak_core,
  node: 'dev_1@127.0.0.1',
  web_port: 8198,
  handoff_port: 8199,
  ring_state_dir: 'ring_data_dir_1',
  platform_data_dir: 'data_1'
