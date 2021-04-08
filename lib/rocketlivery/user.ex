defmodule Rocketlivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rocketlivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @create_required_params [:address, :cep, :cpf, :email, :name, :password]
  @update_required_params @create_required_params -- [:password]
  @derive {Jason.Encoder, only: [:id, :address, :age, :cep, :cpf, :email, :name]}

  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :orders, Order, on_delete: :nilify_all

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:age] ++ @create_required_params)
    |> validate_required(@create_required_params)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> handle_changeset()
    |> put_password_hash()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:age] ++ @update_required_params)
    |> validate_required(@update_required_params)
    |> handle_changeset()
  end

  defp handle_changeset(changeset) do
    changeset
    |> validate_number(:age, greater_than: 17, less_than_or_equal_to: 60)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> unique_constraint(:cpf)
    |> unique_constraint(:email)
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
