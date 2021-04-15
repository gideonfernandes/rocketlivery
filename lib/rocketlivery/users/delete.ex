defmodule Rocketlivery.Users.Delete do
  alias Rocketlivery.{Error, Repo, User}

  def call(id) do
    case Repo.get(User, id) do
      %User{} = user -> Repo.delete(user)
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end
end
