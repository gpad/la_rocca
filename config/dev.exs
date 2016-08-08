use Mix.Config

# Enable debug log on console
# config :lager,
#   handlers: [
#     lager_console_backend: :debug
#   ]

config :erldocker,
  unixbridge_port: 42033,
  docker_http: "http://localhost:42033"
