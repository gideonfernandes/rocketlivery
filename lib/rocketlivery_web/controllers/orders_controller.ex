defmodule RocketliveryWeb.OrdersController do
  use RocketliveryWeb, :controller

  alias Rocketlivery.Order
  alias RocketliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Order{} = order} <- Rocketlivery.create_order(params) do
      conn
      |> put_status(:created)
      |> render("create.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Order{}} <- Rocketlivery.delete_order(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(conn, _params) do
    with {:ok, orders} <- Rocketlivery.index_orders() do
      conn
      |> put_status(:ok)
      |> render("orders.json", orders: orders)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Order{} = order} <- Rocketlivery.get_order(id) do
      conn
      |> put_status(:ok)
      |> render("order.json", order: order)
    end
  end
end
