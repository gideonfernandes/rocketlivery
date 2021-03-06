defmodule Rocketlivery.Repo.Migrations.CreateItemCategoryType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE item_category AS ENUM ('desert', 'drink', 'food')"
    down_query = "DROP TYPE item_category"

    execute(up_query, down_query)
  end
end
