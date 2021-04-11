use Mix.Config

config :rocketlivery, Rocketlivery.Repo,
  username: "postgres",
  password: "postgres",
  database: "rocketlivery_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :rocketlivery, RocketliveryWeb.Endpoint,
  http: [port: 4002],
  server: false

config :rocketlivery, Rocketlivery.Users.Create, via_cep_adapter: Rocketlivery.ViaCep.ClientMock

config :logger, level: :warn
