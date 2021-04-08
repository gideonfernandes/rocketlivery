defmodule Rocketlivery do
  alias Rocketlivery.Items.Create, as: CreateItem
  alias Rocketlivery.Items.Delete, as: DeleteItem
  alias Rocketlivery.Items.Get, as: GetItem
  alias Rocketlivery.Items.Update, as: UpdateItem
  alias Rocketlivery.Users.Create, as: CreateUser
  alias Rocketlivery.Users.Delete, as: DeleteUser
  alias Rocketlivery.Users.Get, as: GetUser
  alias Rocketlivery.Users.Update, as: UpdateUser

  defdelegate create_item(params), to: CreateItem, as: :call
  defdelegate delete_item(id), to: DeleteItem, as: :call
  defdelegate get_item(id), to: GetItem, as: :call
  defdelegate update_item(params), to: UpdateItem, as: :call
  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :call
  defdelegate get_user(id), to: GetUser, as: :call
  defdelegate update_user(params), to: UpdateUser, as: :call
end
