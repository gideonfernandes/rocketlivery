defmodule Rocketlivery.Orders.Delete do
  alias Rocketlivery.{Error, Repo, Order}

  def call(id) do
    with %Order{} = order <- Repo.get(Order, id) do
      Repo.delete(order)
    else
      nil -> {:error, Error.build_order_not_found_error()}
    end
  end
end
