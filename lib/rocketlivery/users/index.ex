defmodule Rocketlivery.Users.Index do
  alias Rocketlivery.{Error, Repo, User}

  def call() do
    with users <- Repo.preload(Repo.all(User), :orders) do
      {:ok, users}
    else
      [] -> {:error, Error.build_users_not_found_error()}
    end
  end
end
