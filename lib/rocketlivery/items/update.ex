defmodule Rocketlivery.Items.Update do
  alias Rocketlivery.{Error, Item, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Item, id) do
      %Item{} = item -> do_update(item, params)
      nil -> {:error, Error.build_item_not_found_error()}
    end
  end

  defp do_update(item, params) do
    item
    |> Item.changeset(params)
    |> Repo.update()
  end
end
