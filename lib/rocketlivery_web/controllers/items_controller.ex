defmodule RocketliveryWeb.ItemsController do
  use RocketliveryWeb, :controller

  alias Rocketlivery.Item
  alias RocketliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Item{} = item} <- Rocketlivery.create_item(params) do
      conn
      |> put_status(:created)
      |> render("create.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Item{}} <- Rocketlivery.delete_item(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(conn, _params) do
    with {:ok, items} <- Rocketlivery.index_items() do
      conn
      |> put_status(:ok)
      |> render("items.json", items: items)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Item{} = item} <- Rocketlivery.get_item(id) do
      conn
      |> put_status(:ok)
      |> render("item.json", item: item)
    end
  end

  def update(conn, params) do
    with {:ok, %Item{} = item} <- Rocketlivery.update_item(params) do
      conn
      |> put_status(:ok)
      |> render("item.json", item: item)
    end
  end
end
