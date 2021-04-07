defmodule Rocketlivery do
  alias Rocketlivery.Users.Create, as: CreateUser
  alias Rocketlivery.Users.Delete, as: DeleteUser
  alias Rocketlivery.Users.Get, as: GetUser
  alias Rocketlivery.Users.Update, as: UpdateUser

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :call
  defdelegate get_user(id), to: GetUser, as: :call
  defdelegate update_user(params), to: UpdateUser, as: :call
end
