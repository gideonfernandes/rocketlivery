defmodule Rocketlivery.Orders.Get do
  alias Rocketlivery.{Error, Order, Repo}

  def call(id) do
    case get_by_id(id) do
      %Order{} = order -> {:ok, order}
      nil -> {:error, Error.build_order_not_found_error()}
    end
  end

  def get_by_id(id) do
    Repo.get(Order, id)
    |> Repo.preload(:items)
  end
end
