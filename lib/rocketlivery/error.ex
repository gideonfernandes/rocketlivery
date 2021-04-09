defmodule Rocketlivery.Error do
  @keys [:status, :result]
  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{status: status, result: result}
  end

  def build_item_not_found_error(), do: build(:not_found, "Item not found!")
  def build_items_not_found_error(), do: build(:not_found, "Items not found!")
  def build_order_not_found_error(), do: build(:not_found, "Order not found!")
  def build_orders_not_found_error(), do: build(:not_found, "Orders not found!")
  def build_user_not_found_error(), do: build(:not_found, "User not found!")
  def build_users_not_found_error(), do: build(:not_found, "Users not found!")
end
