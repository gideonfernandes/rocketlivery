defmodule Rocketlivery.Users.Update do
  alias Rocketlivery.{Error, Repo, User}

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      %User{} = user -> do_update(user, params)
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end

  defp do_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
