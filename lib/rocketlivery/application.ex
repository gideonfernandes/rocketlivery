defmodule Rocketlivery.Application do
  use Application

  def start(_type, _args) do
    children = [
      Rocketlivery.Repo,
      RocketliveryWeb.Telemetry,
      {Phoenix.PubSub, name: Rocketlivery.PubSub},
      RocketliveryWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Rocketlivery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    RocketliveryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
