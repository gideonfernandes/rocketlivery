use Mix.Config

config :rocketlivery, Rocketlivery.Repo,
  username: "postgres",
  password: "postgres",
  database: "rocketlivery_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :rocketlivery, RocketliveryWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
