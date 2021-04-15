defmodule Rocketlivery.Orders.Delete do
  alias Rocketlivery.{Error, Order, Repo}

  def call(id) do
    case Repo.get(Order, id) do
      %Order{} = order -> Repo.delete(order)
      nil -> {:error, Error.build_order_not_found_error()}
    end
  end
end
