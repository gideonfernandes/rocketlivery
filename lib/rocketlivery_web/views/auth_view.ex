defmodule RocketliveryWeb.AuthView do
  use RocketliveryWeb, :view

  alias Rocketlivery.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{token: token, user: user}
  end
end
