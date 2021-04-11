defmodule RocketliveryWeb.Router do
  use RocketliveryWeb, :router

  alias RocketliveryWeb.Plugs.UUIDChecker

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  scope "/api", RocketliveryWeb do
    pipe_through :api

    resources "/items", ItemsController, except: [:new, :edit]
    resources "/orders", OrdersController, except: [:new, :edit, :update]
    resources "/users", UsersController, except: [:new, :edit]
    post "/users/signin", UsersController, :sign_in
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RocketliveryWeb.Telemetry
    end
  end
end
