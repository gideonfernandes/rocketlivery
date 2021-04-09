defmodule RocketliveryWeb.UsersView do
  use RocketliveryWeb, :view

  alias Rocketlivery.User

  def render("create.json", %{user: %User{} = user}) do
    %{message: "User created successfully!", user: user}
  end

  def render("user.json", %{user: %User{} = user}), do: %{user: user}

  def render("users.json", %{users: users}) do
    Enum.map(users, fn user -> render("user.json", user: user) end)
  end
end
