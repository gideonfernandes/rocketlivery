defmodule RocketliveryWeb.Router do
  use RocketliveryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RocketliveryWeb do
    pipe_through :api
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RocketliveryWeb.Telemetry
    end
  end
end
