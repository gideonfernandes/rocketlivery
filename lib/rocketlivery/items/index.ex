defmodule Rocketlivery.Items.Index do
  alias Rocketlivery.{Error, Repo, Item}

  def call() do
    case Repo.preload(Repo.all(Item), :orders) do
      [] -> {:error, Error.build_items_not_found_error()}
      items -> {:ok, items}
    end
  end
end
