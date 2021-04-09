defmodule Rocketlivery.Orders.Get do
  alias Rocketlivery.{Error, Repo, Order}

  def call(id) do
    with %Order{} = order <- Repo.get(Order, id) do
      {:ok, order}
    else
      nil -> {:error, Error.build_order_not_found_error()}
    end
  end
end
