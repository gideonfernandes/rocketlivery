defmodule Rocketlivery.Users.GetByEmail do
  alias Rocketlivery.{Error, Repo, User}

  def call(email) do
    with %User{} = user <- Repo.preload(Repo.get_by(User, email: email), :orders) do
      {:ok, user}
    else
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end
end
