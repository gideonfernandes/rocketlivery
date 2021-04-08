defmodule Rocketlivery.Items.Delete do
  alias Rocketlivery.{Error, Repo, Item}

  def call(id) do
    with %Item{} = item <- Repo.get(Item, id) do
      Repo.delete(item)
    else
      nil -> {:error, Error.build_item_not_found_error()}
    end
  end
end
