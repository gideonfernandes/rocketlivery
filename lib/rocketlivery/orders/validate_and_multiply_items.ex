defmodule Rocketlivery.Orders.ValidateAndMultiplyItems do
  def call(items, item_ids, item_params) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    item_ids
    |> Enum.map(fn id -> {id, Map.get(items_map, id)} end)
    |> Enum.any?(fn {_id, value} -> is_nil(value) end)
    |> multiply_items(items_map, item_params)
  end

  defp multiply_items(false, items_map, item_params) do
    items =
      Enum.reduce(item_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
        current_item = Map.get(items_map, id)
        acc ++ List.duplicate(current_item, quantity)
      end)

    {:ok, items}
  end

  defp multiply_items(true, _items_map, _item_params), do: {:error, "Invalid item IDs!"}
end
