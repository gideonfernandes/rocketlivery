defmodule Rocketlivery.Users.Update do
  alias Rocketlivery.{Error, Repo, User}

  def call(%{"id" => id} = params) do
    with %User{} = user <- Repo.get(User, id) do
      user
      |> User.changeset(params)
      |> Repo.update()
    else
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end
end
