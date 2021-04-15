defmodule Rocketlivery.Repo.Migrations.AddCityAndUfColumnsToUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :uf, :string
      add :city, :string
    end
  end
end
