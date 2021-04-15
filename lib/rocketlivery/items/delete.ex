defmodule Rocketlivery.Items.Delete do
  alias Rocketlivery.{Error, Item, Repo}

  def call(id) do
    case Repo.get(Item, id) do
      %Item{} = item -> Repo.delete(item)
      nil -> {:error, Error.build_item_not_found_error()}
    end
  end
end
