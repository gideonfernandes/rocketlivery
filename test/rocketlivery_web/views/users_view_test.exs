defmodule RocketliveryWeb.UsersViewTest do
  use Rocketlivery.DataCase, async: true

  import Phoenix.View
  import Rocketlivery.Factory

  alias RocketliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created successfully!",
             user: %{
               address: "Rua das Bananeiras",
               age: 22,
               cep: "12345678",
               cpf: "12345678900",
               email: "gideon@gmail.com",
               name: "Gideon Fernandes"
             }
           } = response
  end

  test "renders user.json" do
    user = build(:user)

    response = render(UsersView, "user.json", user: user)

    assert %{
             user: %{
               address: "Rua das Bananeiras",
               age: 22,
               cep: "12345678",
               cpf: "12345678900",
               email: "gideon@gmail.com",
               name: "Gideon Fernandes"
             }
           } = response
  end
end
