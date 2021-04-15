defmodule Rocketlivery.Items.Create do
  alias Ecto.Changeset
  alias Rocketlivery.{Error, Item, Repo}

  def call(params) do
    case Repo.insert(Item.changeset(params)) do
      {:ok, %Item{} = result} -> {:ok, result}
      {:error, %Changeset{} = changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end
end
