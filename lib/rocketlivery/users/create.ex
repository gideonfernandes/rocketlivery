defmodule Rocketlivery.Users.Create do
  alias Ecto.Changeset
  alias Rocketlivery.{Error, Repo, User}

  def call(params) do
    with {:ok, %User{} = result} <- Repo.insert(User.changeset(params)) do
      {:ok, result}
    else
      {:error, %Changeset{} = changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end
end
