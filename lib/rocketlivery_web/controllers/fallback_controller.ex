defmodule RocketliveryWeb.FallbackController do
  use RocketliveryWeb, :controller

  alias Rocketlivery.Error
  alias RocketliveryWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
