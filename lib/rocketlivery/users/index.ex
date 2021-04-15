defmodule Rocketlivery.Users.Index do
  alias Rocketlivery.{Error, Repo, User}

  def call do
    case Repo.preload(Repo.all(User), :orders) do
      [] -> {:error, Error.build_users_not_found_error()}
      users -> {:ok, users}
    end
  end
end
