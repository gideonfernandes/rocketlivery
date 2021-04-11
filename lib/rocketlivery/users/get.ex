defmodule Rocketlivery.Users.Get do
  alias Rocketlivery.{Error, Repo, User}

  def call(id) do
    with %User{} = user <- Repo.preload(Repo.get(User, id), :orders) do
      {:ok, user}
    else
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end
end
