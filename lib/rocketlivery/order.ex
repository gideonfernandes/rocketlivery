defmodule Rocketlivery.Order do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rocketlivery.{Item, User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @payment_methods [:credit_card, :debit_card, :money]
  @required_params [:address, :comments, :payment_method, :user_id]
  @derive {Jason.Encoder, only: [:id] ++ @required_params}

  schema "items" do
    field :address, :string
    field :comments, :string
    field :payment_method, Ecto.Enum, values: @payment_methods

    belongs_to :user, User
    many_to_many :items, Item, join_through: "orders_items"

    timestamps()
  end

  def changeset(params, items) do
    %__MODULE__{}
    |> handle_changeset(params, items)
  end

  def changeset(struct, params, items) do
    struct
    |> handle_changeset(params, items)
  end

  defp handle_changeset(changeset, params, items) do
    changeset
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_assoc(:items, items)
    |> validate_length(:comments, min: 10)
    |> validate_length(:description, min: 6)
  end
end
