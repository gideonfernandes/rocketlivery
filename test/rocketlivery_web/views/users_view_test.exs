defmodule RocketliveryWeb.UsersViewTest do
  use Rocketlivery.DataCase, async: true

  import Phoenix.View
  import Rocketlivery.Factory

  alias RocketliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    token = "an_auth_token"

    response = render(UsersView, "create.json", token: token, user: user)

    assert %{
             message: "User created successfully!",
             token: "an_auth_token",
             user: %{
               address: "Rua das Bananeiras",
               age: 22,
               cep: "12345678",
               city: "Araras",
               cpf: "12345678900",
               email: "gideon@gmail.com",
               name: "Gideon Fernandes",
               password: "123456",
               uf: "SP"
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
