defmodule RocketliveryWeb.ItemsView do
  use RocketliveryWeb, :view

  alias Rocketlivery.Item

  def render("create.json", %{item: %Item{} = item}) do
    %{message: "Item created successfully!", item: item}
  end

  def render("item.json", %{item: %Item{} = item}), do: %{item: item}

  def render("items.json", %{items: items}) do
    Enum.map(items, fn item -> render("item.json", item: item) end)
  end
end
