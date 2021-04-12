defmodule Rocketlivery.Item do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rocketlivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @item_categories [:desert, :drink, :food]
  @required_params [:category, :description, :photo, :price]
  @derive {Jason.Encoder, only: [:id] ++ @required_params}

  schema "items" do
    field :category, Ecto.Enum, values: @item_categories
    field :description, :string
    field :photo, :string
    field :price, :decimal

    many_to_many :orders, Order, join_through: "orders_items", on_delete: :delete_all

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> handle_changeset(params)
  end

  def changeset(struct, params) do
    struct
    |> handle_changeset(params)
  end

  defp handle_changeset(changeset, params) do
    changeset
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)
  end
end
