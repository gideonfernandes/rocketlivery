defmodule RocketliveryWeb.UsersControllerTest do
  use RocketliveryWeb.ConnCase, async: true

  import Mox
  import Rocketlivery.Factory

  alias Rocketlivery.User
  alias Rocketlivery.ViaCep.ClientMock
  alias RocketliveryWeb.Auth.Guardian

  describe "create/2" do
    test "creates the user, when all params are valid", %{conn: conn} do
      params = build(:user_valid_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created successfully!",
               "user" => %{
                 "address" => "Rua das Bananeiras",
                 "age" => 22,
                 "cep" => "12345678",
                 "cpf" => "12345678900",
                 "email" => "gideon@gmail.com",
                 "id" => _id,
                 "name" => "Gideon Fernandes"
               }
             } = response
    end
  end

  test "returns an error, when there are invalid params", %{conn: conn} do
    params = build(:user_invalid_params)

    response =
      conn
      |> post(Routes.users_path(conn, :create, params))
      |> json_response(:bad_request)

    expected_response = %{
      "message" => %{
        "address" => ["can't be blank"],
        "age" => ["must be greater than 17"],
        "cep" => ["should be 8 character(s)"],
        "cpf" => ["should be 11 character(s)"],
        "email" => ["has invalid format"],
        "name" => ["can't be blank"],
        "password" => ["should be at least 6 character(s)"],
        "password_confirmation" => ["does not match confirmation"]
      }
    }

    assert response === expected_response
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn}
    end

    test "deletes the user, when there is an user with the given id", %{conn: conn} do
      %User{id: id} = insert(:user, cpf: "12345678901", email: "gideon1@gmail.com")

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response === ""
    end
  end
end
