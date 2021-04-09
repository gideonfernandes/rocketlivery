defmodule Rocketlivery.Orders.Index do
  alias Rocketlivery.{Error, Repo, Order}

  def call() do
    with orders <- Repo.preload(Repo.all(Order), :items) do
      {:ok, orders}
    else
      [] -> {:error, Error.build_orders_not_found_error()}
    end
  end
end
