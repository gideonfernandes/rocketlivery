defmodule Rocketlivery.Items.Update do
  alias Rocketlivery.{Error, Repo, Item}

  def call(%{"id" => id} = params) do
    with %Item{} = item <- Repo.get(Item, id) do
      item
      |> Item.changeset(params)
      |> Repo.update()
    else
      nil -> {:error, Error.build_item_not_found_error()}
    end
  end
end
