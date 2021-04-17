defmodule RocketliveryWeb.AuthControllerTest do
  use RocketliveryWeb.ConnCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.{Repo, User}

  describe "create/2" do
    setup %{conn: conn} do
      {:ok, user} =
        build(:user_valid_params)
        |> User.changeset()
        |> Repo.insert()

      {:ok, conn: conn, user: user}
    end

    test "returns an authenticated user when there are valid credentials", %{
      conn: conn,
      user: user
    } do
      params = %{"email" => user.email, "password" => user.password}

      response =
        conn
        |> post(Routes.auth_path(conn, :create, params))
        |> json_response(:ok)

      assert %{
               "token" => _token,
               "user" => %{
                 "address" => "Rua das Bananeiras",
                 "cep" => "12345678",
                 "email" => "gideon@gmail.com",
                 "name" => "Gideon Fernandes"
               }
             } = response
    end

    test "returns an error when the user there are invalid credentials", %{conn: conn, user: user} do
      params = %{"email" => user.email, "password" => "654321"}

      response =
        conn
        |> post(Routes.auth_path(conn, :create, params))
        |> json_response(:unauthorized)

      expected_response = %{"message" => "Please verify your credentials!"}

      assert expected_response === response
    end

    test "returns an error when the user by email is not found", %{conn: conn} do
      params = %{"email" => "test_not_found@gmail.com", "password" => "123456"}

      response =
        conn
        |> post(Routes.auth_path(conn, :create, params))
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found!"}

      assert expected_response === response
    end
  end
end
