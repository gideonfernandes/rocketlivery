defmodule Rocketlivery.Users.GetByEmail do
  alias Rocketlivery.{Error, Repo, User}

  def call(email) do
    case get_by_email(email) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end

  defp get_by_email(email) do
    Repo.get_by(User, email: email)
    |> Repo.preload(:orders)
  end
end
