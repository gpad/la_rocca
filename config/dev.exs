use Mix.Config

# Enable debug log on console
config :lager,
  handlers: [
    lager_console_backend: :debug,
  ]
