defmodule Rocketlivery.Items.Index do
  alias Rocketlivery.{Error, Item, Repo}

  def call do
    case Repo.all(Item) do
      [] -> {:error, Error.build_items_not_found_error()}
      items -> {:ok, items}
    end
  end
end
