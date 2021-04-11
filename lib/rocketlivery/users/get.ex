defmodule Rocketlivery.Users.Get do
  alias Rocketlivery.{Error, Repo, User}

  def call(id) do
    with %User{} = user <- Repo.preload(Repo.get(User, id), :orders) do
      {:ok, user}
    else
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end

  def get_by_email(email) do
    with %User{} = user <- Repo.preload(Repo.get_by(User, email: email), :orders) do
      {:ok, user}
    else
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end
end
