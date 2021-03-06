use Mix.Config

config :rocketlivery,
  ecto_repos: [Rocketlivery.Repo]

config :rocketlivery, RocketliveryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "I/yCNyEygpYWH6TAdkJG7xuFYz9fda1ih6SwqrgDMqtpYysDl+o0/YFrQd08sy5B",
  render_errors: [view: RocketliveryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rocketlivery.PubSub,
  live_view: [signing_salt: "f8J0al2+"]

config :rocketlivery, Rocketlivery.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :rocketlivery, Rocketlivery.Users.Create, via_cep_adapter: Rocketlivery.ViaCep.Client

config :rocketlivery, RocketliveryWeb.Auth.Guardian,
  issuer: "rocketlivery",
  secret_key: "TXXAFr6h/o26LsHDdZWvX3izhZpRzHsHtsqLhfMPwYhHn4Wh7yTySKjHZFc+t9zb"

config :rocketlivery, RocketliveryWeb.Auth.Pipeline,
  module: RocketliveryWeb.Auth.Guardian,
  error_handler: RocketliveryWeb.Auth.ErrorHandler

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
