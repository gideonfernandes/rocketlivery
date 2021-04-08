defmodule Rocketlivery.Items.Create do
  alias Ecto.Changeset
  alias Rocketlivery.{Error, Repo, Item}

  def call(params) do
    with {:ok, %Item{} = result} <- Repo.insert(Item.changeset(params)) do
      {:ok, result}
    else
      {:error, %Changeset{} = changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end
end
