defmodule RocketliveryWeb.OrdersView do
  use RocketliveryWeb, :view

  alias Rocketlivery.Order

  def render("create.json", %{order: %Order{} = order}) do
    %{message: "Order created successfully!", order: order}
  end

  def render("order.json", %{order: %Order{} = order}), do: %{order: order}

  def render("orders.json", %{orders: orders}) do
    Enum.map(orders, fn order -> render("order.json", order: order) end)
  end
end
