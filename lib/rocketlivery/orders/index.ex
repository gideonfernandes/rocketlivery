defmodule Rocketlivery.Orders.Index do
  alias Rocketlivery.{Error, Repo, Order}

  def call() do
    case Repo.preload(Repo.all(Order), :items) do
      [] -> {:error, Error.build_orders_not_found_error()}
      orders -> {:ok, orders}
    end
  end
end
