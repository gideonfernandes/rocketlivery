defmodule Rocketlivery.Items.Index do
  alias Rocketlivery.{Error, Repo, Item}

  def call() do
    with items <- Repo.preload(Repo.all(Item), :orders) do
      {:ok, items}
    else
      [] -> {:error, Error.build_items_not_found_error()}
    end
  end
end
