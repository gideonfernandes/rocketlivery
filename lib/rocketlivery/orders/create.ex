defmodule Rocketlivery.Orders.Create do
  import Ecto.Query

  alias Ecto.Changeset
  alias Rocketlivery.{Error, Item, Order, Repo}
  alias Rocketlivery.Orders.ValidateAndMultiplyItems

  def call(params) do
    with {:ok, items} <- fetch_items(params),
         {:ok, %Order{} = result} <- Repo.insert(Order.changeset(params, items)) do
      {:ok, result}
    else
      {:error, %Changeset{} = changeset} -> {:error, Error.build(:bad_request, changeset)}
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  defp fetch_items(%{"items" => item_params}) do
    item_ids = Enum.map(item_params, fn item -> item["id"] end)
    query = from item in Item, where: item.id in ^item_ids

    query
    |> Repo.all()
    |> ValidateAndMultiplyItems.call(item_ids, item_params)
  end
end
