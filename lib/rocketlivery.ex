defmodule Rocketlivery do
  alias Rocketlivery.Items.Create, as: CreateItem
  alias Rocketlivery.Items.Delete, as: DeleteItem
  alias Rocketlivery.Items.Get, as: GetItem
  alias Rocketlivery.Items.Index, as: IndexItems
  alias Rocketlivery.Items.Update, as: UpdateItem
  alias Rocketlivery.Orders.Create, as: CreateOrder
  alias Rocketlivery.Orders.Delete, as: DeleteOrder
  alias Rocketlivery.Orders.Get, as: GetOrder
  alias Rocketlivery.Orders.Index, as: IndexOrders
  alias Rocketlivery.Users.Create, as: CreateUser
  alias Rocketlivery.Users.Delete, as: DeleteUser
  alias Rocketlivery.Users.Get, as: GetUser
  alias Rocketlivery.Users.Index, as: IndexUsers
  alias Rocketlivery.Users.Update, as: UpdateUser

  defdelegate create_item(params), to: CreateItem, as: :call
  defdelegate delete_item(id), to: DeleteItem, as: :call
  defdelegate get_item(id), to: GetItem, as: :call
  defdelegate index_items(), to: IndexItems, as: :call
  defdelegate update_item(params), to: UpdateItem, as: :call
  defdelegate create_order(params), to: CreateOrder, as: :call
  defdelegate delete_order(id), to: DeleteOrder, as: :call
  defdelegate index_orders(), to: IndexOrders, as: :call
  defdelegate get_order(id), to: GetOrder, as: :call
  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :call
  defdelegate get_user(id), to: GetUser, as: :call
  defdelegate index_users(), to: IndexUsers, as: :call
  defdelegate update_user(params), to: UpdateUser, as: :call
end
