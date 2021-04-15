defmodule Rocketlivery.Users.Get do
  alias Rocketlivery.{Error, Repo, User}

  def call(id) do
    case get_by_id(id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end

  def get_by_id(id) do
    Repo.get(User, id)
    |> Repo.preload(:orders)
  end
end
